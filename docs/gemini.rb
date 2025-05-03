api_key = ENV['GEMINI_API_KEY'] if api_key.nil?
opts = { model: 'gemini-2.0-flash-lite' }
x = Ai::Gemini.new(api_key: api_key, **opts)
x = AI::Gemini.new(api_key: api_key, **opts)
ans = x.invoke(messages: [
  { role: 'user', parts: [{ text: 'What is Ruby on Rails?' }] }
])

api_key = ENV['OPENROUTER_API_KEY'] if api_key.nil?
opts = { model: 'deepseek/deepseek-r1:free' }
x = AI::OpenRouter.new(api_key: api_key, **opts)
ans = x.invoke(messages: [
  { role: 'user', content: 'What is Ruby on Rails?' }
])
