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

    def invoke(messages:, tools: nil, is_json_response: true)
      body = {
        model: client_options[:model] || 'gpt-4',
        messages: messages,
        tools: tools,
        tool_choice: tools ? "auto" : nil
      }.compact

      response = self.class.post(llm, headers: headers, body: body.to_json)
      is_json_response ? response.parsed_response : response.body
    end

    def headers
      {
        "Authorization" => "Bearer #{api_key}",
        "Content-Type" => "application/json"
      }
    end
  end
end
