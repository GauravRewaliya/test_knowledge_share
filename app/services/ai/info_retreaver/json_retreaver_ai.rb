module Ai::InfoRetreaver::JsonRetreaverAi
  def self.process(json_body, query: nil, messages: list[str] = [])
    ## json cleaner just 1st array
    datas = JsonProcessing.extract_first_array(json_body)
    ### clean more the structure
    cleaner_formate = ScrapperAi::GetCleanerJsonFormate.process(datas)
    cleaned_json_request = cleaner_formate.process(json_body: json_body) # internally have basic_cleaner , ai_cleaner_code
    # split into chunks if required
    basic_system_messages = []
    if query.nil?
      query = <<-QUERY
        You are a smart agent which role is to fetch usefull information from json.
        send response in json formate with latest and most usefull information.
      QUERY
    end
    basic_system_messages << Message(role: 'system', content: query)
    messages.each do |message|
      basic_system_messages << Message(role: "user", content: message)
    end
    past_conclusions = []
    cleaned_json_request.each do |data|
      past_conclusions.push Ai::Gemini.new(api_key: ENV['GEMINI_API_KEY'], model: 'gemini-2.0-flash-lite').invoke(messages: [**basic_system_messages,Message(role: 'user', content: json_body)], is_json_response: false)
    end
    ## process over all response
    if past_conclusions.length > 1
      messages = []
      past_conclusions.each do |past_conclusion|
        messages << Message(role: 'user', content: past_conclusion)
      end
      response = Ai::Gemini.new(api_key: ENV['GEMINI_API_KEY'], model: 'gemini-2.0-flash-lite')
        .invoke(messages: [
          **basic_system_messages,
          **messages
        ], is_json_response: false)
    else
      response = past_conclusions.last
    end
    return {
      cleaned_json_request: cleaned_json_request,
      response: response,
      past_conclusions: past_conclusions
    }
  end
end