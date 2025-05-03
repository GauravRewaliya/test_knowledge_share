# lib/ai/base.rb
require 'httparty'

module AI
  class Base
    include HTTParty

    attr_reader :api_key, :client_options

    def initialize(api_key:, **client_options)
      @api_key = api_key
      @client_options = client_options
    end

    def client
      self.class
    end

    def llm
      raise NotImplementedError, "Each adapter must define its own llm method"
    end

    def embedder(content:)
      raise NotImplementedError, "Each adapter must define its own embedder method"
    end

    def invoke(messages:, tools: nil, is_json_response: true)
      raise NotImplementedError, "Each adapter must define its own invoke method"
    end
  end
end
