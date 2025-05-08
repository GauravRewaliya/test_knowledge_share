class ServiceAi
  def self.build(provider:, api_key: nil, **opts)
    case provider.to_s.downcase
    when 'openai'
      api_key = ENV['OPENAI_API_KEY'] if api_key.nil?
      raise ArgumentError, "Missing OPENAI_API_KEY" if api_key.nil?
      opts[:model] ||= 'gpt-4o-mini'
      AI::OpenAI.new(api_key: api_key, **opts)
    when 'gemini'
      api_key = ENV['GEMINI_API_KEY'] if api_key.nil?
      raise ArgumentError, "Missing GEMINI_API_KEY" if api_key.nil?
      opts[:model] ||= 'gemini-2.0-flash-lite'
      AI::Gemini.new(api_key: api_key, **opts)
    when 'openrouter'
      api_key = ENV['OPENROUTER_API_KEY'] if api_key.nil?
      raise ArgumentError, "Missing OPENROUTER_API_KEY" if api_key.nil?
      opts[:model] ||= 'deepseek/deepseek-r1:free'
      AI::OpenRouter.new(api_key: api_key, **opts)
    else
      raise ArgumentError, "Unknown provider: #{provider}"
    end
  end
end
# 
# ai = AI::Service.build(provider: :openai, api_key: ENV['OPENAI_API_KEY'], model: 'gpt-3.5-turbo')
# response = ai.invoke(messages: [{ role: 'user', content: 'What is Ruby on Rails?' }])
# ai = ServiceAi.build(provider: "gemini")
# response = ai.invoke(messages: [ { role: 'user', parts: [{ text: 'What is Ruby on Rails?' }] }])
# puts response["choices"].first["message"]["content"]
# 