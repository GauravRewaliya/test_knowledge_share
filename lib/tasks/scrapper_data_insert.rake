namespace :scrapper_data_insert do
  desc "TODO"
  task byjus_paper: :environment do
    auth_token = ""
    paper_id = "5a2edbd0-1759-11ea-bf97-26ccc59f8e91"
    print _fetch_byjus_practice_papers(auth_token: auth_token, paper_id: paper_id)
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

def _fetch_byjus_practice_papers(auth_token:, paper_id:)
  # url = f"https://mule.byjusexamprep.com/?operationName=slug&variables=%7B%22slug%22%3A%22ssc-exams/ssc-cgl-exam%22%2C%22pageType%22%3A%22Pysp%22%2C%22filter%22%3A%22Pysp%22%7D&extensions=%7B%22persistedQuery%22%3A%7B%22version%22%3A1%2C%22sha256Hash%22%3A%22a899c43bae4d4d02b1e5951f913b9e6d984af043b2616c70e5a9370c3329cf13%22%7D%7D"
  # url = f"https://mule.byjusexamprep.com/?operationName=webgetPyspAttempt&variables=%7B%22id%22%3A%2261f33cb0-3eef-11ed-9b40-4cf2e41b23db%22%7D&extensions=%7B%22persistedQuery%22%3A%7B%22version%22%3A1%2C%22sha256Hash%22%3A%228c0941db965dbb44aac8628720d039b11f2085bfc3dc13367b72c57331beb911%22%7D%7D"
  # https://mule.byjusexamprep.com/?operationName=webgetPyspAttempt&variables=%7B%22id%22%3A%224d0ef4a0-2e18-11ea-82cc-afad9169d515%22%7D&extensions=%7B%22persistedQuery%22%3A%7B%22version%22%3A1%2C%22sha256Hash%22%3A%228c0941db965dbb44aac8628720d039b11f2085bfc3dc13367b72c57331beb911%22%7D%7D
  # https://mule.byjusexamprep.com/?operationName=webgetPyspAttempt&variables=%7B%22id%22%3A%221f170700-fefb-11e9-9edb-962465779361%22%7D&extensions=%7B%22persistedQuery%22%3A%7B%22version%22%3A1%2C%22sha256Hash%22%3A%228c0941db965dbb44aac8628720d039b11f2085bfc3dc13367b72c57331beb911%22%7D%7D
  # https://mule.byjusexamprep.com/?operationName=webgetPyspAttempt&variables=%7B%22id%22%3A%22b295d430-b191-11eb-87aa-c1b976054474%22%2C%22lang%22%3A%22en%22%7D&extensions=%7B%22persistedQuery%22%3A%7B%22version%22%3A1%2C%22sha256Hash%22%3A%228c0941db965dbb44aac8628720d039b11f2085bfc3dc13367b72c57331beb911%22%7D%7D
  # 
  # https://mule.byjusexamprep.com/?operationName=GetPyspForExam&variables=%7B%22id%22%3A%2272975611-4a5e-11e5-a83f-8b51c790d8b8%22%2C%22last%22%3A8%7D&extensions=%7B%22persistedQuery%22%3A%7B%22version%22%3A1%2C%22sha256Hash%22%3A%2231a016e43cff670c1d676491dd279fef9fd56251aaebbfd29cdc37194c8cc59a%22%7D%7D

  # https://mule.byjusexamprep.com/?operationName=webgetPyspAttempt&variables=%7B%22id%22%3A%2263a607e0-e034-11ed-b69c-340e1e0ea3ab%22%7D&extensions=%7B%22persistedQuery%22%3A%7B%22version%22%3A1%2C%22sha256Hash%22%3A%228c0941db965dbb44aac8628720d039b11f2085bfc3dc13367b72c57331beb911%22%7D%7D
  # 2263a607e0-e034-11ed-b69c-340e1e0ea3ab
  # https://mule.byjusexamprep.com/?operationName=GetPyspForExam&variables=%7B%22id%22%3A%22980fe8a0-b9b5-11ea-bbbf-1109a752b7f3%22%2C%22last%22%3A8%7D&extensions=%7B%22persistedQuery%22%3A%7B%22version%22%3A1%2C%22sha256Hash%22%3A%2231a016e43cff670c1d676491dd279fef9fd56251aaebbfd29cdc37194c8cc59a%22%7D%7D
  # ttps://mule.byjusexamprep.com/?operationName=slug&variables=%7B%22slug%22%3A%22up-state-exams%22%2C%22pageType%22%3A%22Pysp%22%2C%22filter%22%3A%22Pysp%22%7D&extensions=%7B%22persistedQuery%22%3A%7B%22version%22%3A1%2C%22sha256Hash%22%3A%22a899c43bae4d4d02b1e5951f913b9e6d984af043b2616c70e5a9370c3329cf13%22%7D%7D

  # https://mule.byjusexamprep.com/?operationName=webGetMyInfo&variables=%7B%22filter%22%3A%22skipK12%22%2C%22app%22%3A%22gradeup%22%7D&extensions=%7B%22persistedQuery%22%3A%7B%22version%22%3A1%2C%22sha256Hash%22%3A%229f8139a57ed90141d4d3aebcae86b5f6b0d19e47588c5ccf886d8bb0fb623fee%22%7D%7D

  base_url = "https://mule.byjusexamprep.com/"
  operation_name = "webgetPyspAttempt"
  sha256_hash = "8c0941db965dbb44aac8628720d039b11f2085bfc3dc13367b72c57331beb911"
  primary_exam_id = '72975611-4a5e-11e5-a83f-8b51c790d8b8'

  variables = {id: paper_id}.to_json
  extensions = {persistedQuery: {version: 1, sha256Hash: sha256_hash}}.to_json

  meta_data = {
    "method" => "get",
    "headers" => {
      "Accept" => "application/json",
      "User-Agent" => "Mozilla/5.0",
      # "Authorization" => "Bearer #{auth_token}",
      "Cookie" => "g-theme=LIGHT; primary_exam_id=#{primary_exam_id}; primary_exam_slug=bank-exams"
    },
    # "body" => {
    #   "operationName" => operation_name,
    #   "variables" => variables,
    #   "extensions" => extensions
    # },
    "extra_info": {
      "paper_id": paper_id
    }
  }

  url = "#{base_url}?operationName=#{operation_name}&paper_id=#{primary_exam_id}"

  return _insert_data(
    url: url,
    meta_data: meta_data,
    sub_type: "byjus_practice_papers",
    parser_info: nil,
    source_provider: "byjus"
  )
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
