namespace :scrapper_data_insert do
  desc "TODO"
  task byjus_paper: :environment do
  end

  desc "TODO"
  task byjus_more_info: :environment do
  end

  desc "Testbook"
  task testbook_papers: :environment do
    auth_token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3Rlc3Rib29rLmNvbSIsInN1YiI6IjYxZGMwOGE0MjMzZjAzZjQ3MGRlMWI1MyIsImF1ZCI6IlRCIiwiZXhwIjoiMjAyNS0wNi0wMlQxMTo0MToyOS44NDY1MzAzMDlaIiwiaWF0IjoiMjAyNS0wNS0wM1QxMTo0MToyOS44NDY1MzAzMDlaIiwib3JnSWQiOiIiLCJpc0xNU1VzZXIiOmZhbHNlLCJyb2xlcyI6InN0dWRlbnQifQ.K0udzUrnq-WXc3nG1MJZjkIMcArNT3rgBf4tpEfnA8Vkv57svJG8-T02bbn0zA8bjE23EgaM63_wVk4cYYY9Xhf-WuwrGGLjxFtEnFQjByXLon0FRpqfavCyIUSRqAfADc4dhETEfeMk52_ZzeUp21tYh6JjPnxDXzyVZ-8Wwsw"
    test_ids = ["65eea6dad687c6bfc666fab0", "65f16b0251bc3e91e15b0ab7"]
    test_ids.each do |test_id|
      print _fetch_test(test_id: test_id, auth_token: auth_token)
    end
  end
  
  desc "subject chapters"
  task testbook_subject_chapters: :environment do
    auth_token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3Rlc3Rib29rLmNvbSIsInN1YiI6IjYxZGMwOGE0MjMzZjAzZjQ3MGRlMWI1MyIsImF1ZCI6IlRCIiwiZXhwIjoiMjAyNS0wNi0wMlQxMTo0MToyOS44NDY1MzAzMDlaIiwiaWF0IjoiMjAyNS0wNS0wM1QxMTo0MToyOS44NDY1MzAzMDlaIiwib3JnSWQiOiIiLCJpc0xNU1VzZXIiOmZhbHNlLCJyb2xlcyI6InN0dWRlbnQifQ.K0udzUrnq-WXc3nG1MJZjkIMcArNT3rgBf4tpEfnA8Vkv57svJG8-T02bbn0zA8bjE23EgaM63_wVk4cYYY9Xhf-WuwrGGLjxFtEnFQjByXLon0FRpqfavCyIUSRqAfADc4dhETEfeMk52_ZzeUp21tYh6JjPnxDXzyVZ-8Wwsw"
    subject_id = "60881af444b1c5c7c9974fa3"
    chapter_id = "6091f7e200a47916d76a837b"
    section_id = "60c9c547a872c2695488f0a1"
    groupId= "60881a9844b1c5c7c9974fa2"
    print _fetch_testbook_chapters(chapter_id: chapter_id,auth_token: auth_token)
    # print _fetch_chapters_of_sub(sub_id: subject_id, auth_token: auth_token)
  end

end

def _fetch_testbook_chapters(chapter_id:, auth_token:)
  url = "https://api.testbook.com/api/v2/study-tab/chapters/#{chapter_id}/practice-sections"
  meta_data = {
    "method" => "get",
    "headers" => {
      "Accept": "application/json",
      "User-Agent": "Mozilla/5.0",
      
      "Authorization" => "Bearer #{auth_token}",
      "X-Tb-Client" => "web,1.2",
      "Accept-Language" => "English"
    },
    "body" => {"language": "English"}
  }
  return _insert_data(
    url: url,
    meta_data: meta_data,
    sub_type: "testbook_chapters",
    parser_info: nil,
    source_provider: "testbook"
  )
end

def _fetch_chapters_of_sub(sub_id:, auth_token:)
  url = "https://api.testbook.com/api/v2/study-tab/subjects/#{sub_id}/chapters"
  meta_data = {
    "method" => "get",
    "headers" => {
      "Accept": "application/json",
      "User-Agent": "Mozilla/5.0",  
      "Authorization" => "Bearer #{auth_token}",
      "X-Tb-Client" => "web,1.2",
      "Accept-Language" => "English"
    }
  }
  return _insert_data(
    url: url,
    meta_data: meta_data,
    sub_type: "testbook_subject_chapters",
    parser_info: nil,
    source_provider: "testbook"
    )
end
  
def _fetch_test(test_id:, auth_token:)
  url = "https://api.testbook.com/api/v2/tests/#{test_id}"
  meta_data = {
    "method" => "post",
    "headers" => {
      "Accept"=> "application/json",
      "User-Agent"=> "Mozilla/5.0",  
      "Authorization" => "Bearer #{auth_token}",
      "X-Tb-Client" => "web,1.2",
      "Accept-Language" => "English"
    },
    "url" => "https://api.testbook.com/api/v2/tests/#{test_id}"
  }
  return _insert_data(
    url: url,
    meta_data: meta_data,
    sub_type: "test_paper",
    parser_info: nil,
    source_provider: "testbook"
  )
end

# meta_data = {"method": "get", "headers": {}, "body": {}, "url": "https://www.byjus.com/"}

def _insert_data(url:, meta_data:, sub_type: nil, parser_info: nil, source_provider:)
  scrapper_db = ScrapperDb.find_by(url: url)
  if scrapper_db.present?
    return scrapper_db.response
  else
    if meta_data["method"] == "get"
      options = {}
      options[:headers] = meta_data["headers"] if meta_data["headers"].present?
      options[:params] = meta_data["body"] if meta_data["body"].present?
      data = HTTParty.get(url, options)
    elsif meta_data["method"] == "post"
      options = {}
      options[:headers] = meta_data["headers"] if meta_data["headers"].present?
      options[:body] = meta_data["body"] if meta_data["body"].present?
      data = HTTParty.post(url, options)
    end
    return data unless data.code == 200
    scrapper_db = ScrapperDb.new(
      url: url,
      response: data,
      meta_data: meta_data,
      sub_type: sub_type,
      parser_info: parser_info,
      source_provider: source_provider
    )
    scrapper_db.save
    return data
  end
end
## list the data FE

## is URL is present -> return the response
