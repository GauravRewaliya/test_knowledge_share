# lib/ai/service.rb
require_relative 'openai'
require_relative 'gemini'
require_relative 'openrouter'

module Service
  class AI
    def self.build(provider:, api_key:, **opts)
      case provider.to_s.downcase
      when 'openai'
        OpenAI.new(api_key: api_key, **opts)
      when 'gemini'
        Gemini.new(api_key: api_key, **opts)
      when 'openrouter'
        OpenRouter.new(api_key: api_key, **opts)
      else
        raise ArgumentError, "Unknown provider: #{provider}"
      end
    end
  end
end

# 
# ai = AI::Service.build(provider: :openai, api_key: ENV['OPENAI_API_KEY'], model: 'gpt-3.5-turbo')

# response = ai.invoke(messages: [{ role: 'user', content: 'What is Ruby on Rails?' }])
# puts response["choices"].first["message"]["content"]
# 