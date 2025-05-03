require_relative 'constraint/openai_base'

module AI
  class OpenRouter < OpenAIBase
    def base_url
      'https://openrouter.ai/api/v1'
    end

    def headers
      super.merge({
        "HTTP-Referer" => client_options[:referer] || "http://localhost"
      })
    end
  end
end
