module ScrapperAi
  class GetCleanerJsonFormate
    def self._system_prompt
      return <<~PROMPT
      you got an json string, you need to clean it and return a new json string which excluded the unrequred and empty or useless fields
      "Return JSON only"
      PROMPT
    end
    def self.process(json_body)
      messages = [Message(role: 'system', content: _system_prompt), Message(role: 'user', content: json_body)]
      response = Ai::Gemini.new(api_key: ENV['GEMINI_API_KEY'], model: 'gemini-2.0-flash-lite').invoke(messages: messages , is_json_response: true)
      return response
    end
  end
end