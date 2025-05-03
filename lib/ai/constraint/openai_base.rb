require_relative '../base'

module AI
  class OpenAIBase < Base
    def base_url
      'https://api.openai.com/v1'
    end

    def llm
      "#{base_url}/chat/completions"
    end

    def embedder(content:)
      response = self.class.post(
        "#{base_url}/embeddings",
        headers: headers,
        body: {
          model: client_options[:embed_model] || 'text-embedding-ada-002',
          input: content
        }.to_json
      )
      response.parsed_response['data']
    end

    def invoke(messages:, tools: nil, is_json_response: false)
      body = {
        model: client_options[:model] || 'gpt-4',
        messages: messages,
        tools: tools,
        tool_choice: tools ? "auto" : nil
      }.compact

      response = self.class.post(llm, headers: headers, body: body.to_json)
      if response.code == 200
        if is_json_response
          { code: 200, obj: response }
        else
          { 
            code: 200, 
            content: response.parsed_response["choices"][0]["message"]["content"],
            error: nil,
            metadata: {
              finish_reason: response.parsed_response["choices"][0]["finish_reason"],
              usage: response.parsed_response["usage"]
            }
          }
        end
      else
        if is_json_response
          { code: response.code, content: nil, error: response.parsed_response, metadata: nil, obj: response }
        else
          { code: response.code, content: nil, error: response.body, metadata: nil, obj: response }
        end
      end
    end

    def headers
      {
        "Authorization" => "Bearer #{api_key}",
        "Content-Type" => "application/json"
      }
    end
  end
end
