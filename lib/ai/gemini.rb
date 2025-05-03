# lib/ai/gemini.rb
require_relative 'base'

module AI
  class Gemini < Base
    BASE_URL = 'https://generativelanguage.googleapis.com/v1beta/models'

    def llm
      "#{BASE_URL}/#{client_options[:model] || 'gemini-pro'}:generateContent"
    end

    def embedder(content:)
      url = "#{BASE_URL}/embedding-001:embedContent?key=#{api_key}"
      response = self.class.post(
        url,
        headers: headers,
        body: { content: { parts: [{ text: content }] } }.to_json
      )
      response.parsed_response['embedding']
    end

    def invoke(messages:, tools: nil, is_json_response: true)
      url = "#{llm}?key=#{api_key}"
      prompt = {
        contents: messages
      }

      response = self.class.post(url, headers: headers, body: prompt.to_json)
      is_json_response ? response.parsed_response : response.body
    end

    private

    def headers
      { "Content-Type" => "application/json" }
    end
  end
end
