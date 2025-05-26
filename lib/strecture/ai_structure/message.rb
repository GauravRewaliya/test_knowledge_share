module AiStructure
  class Message
    attr_accessor :role, :content

    def initialize(role:, content:)
      @role = role
      @content = content
    end

    def to_h
      { role: role, content: content }
    end
  end
end
