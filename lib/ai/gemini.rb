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

    def invoke(messages:, tools: nil, is_json_response: false)
      url = "#{llm}?key=#{api_key}"
      prompt = {
        contents: messages
      }

      response = self.class.post(url, headers: headers, body: prompt.to_json)
      # is_json_response ? response.parsed_response : response.body
      if response.code == 200
        if is_json_response
          return { code: 200, obj: response }
        else
          return { code: 200, content: response.parsed_response["candidates"][0]["content"]["parts"][0]["text"], error: nil, metadata: { finish_reason: response.parsed_response["candidates"][0]["finishReason"], usage: response.parsed_response["usageMetadata"] } }        end
      else
        if is_json_response
          return { code: response.code, content: nil, error: response.parsed_response, metadata: nil ,obj: response }
        else
          return { code: response.code, content: nil, error: response.body, metadata: nil ,obj: response }
        end
      end
    end

    private

    def headers
      { "Content-Type" => "application/json" }
    end
  end
end
