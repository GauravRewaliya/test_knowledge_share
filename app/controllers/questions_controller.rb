class QuestionsController < ApplicationController
  def index
    @questions = []
    i = 5
    
    5.times.each do |i|
      @questions << Question.new(
        id: i,
        content: Faker::Lorem.sentence(word_count: rand(50..70) ),
        tags: ["tag1", "tag2"],
        options: [
          { id: 1, "content": "Option 1"},
          { id: 2, "content": "Option 2"},
          { id: 3, "content": "Option 3"},
          { id: 4, "content": "Option 4"},
        ],
        correct_option: 1
      )
    end
    # layout_name = "card_1"
    layout_name = "card_2"
    render layout_name
  end  
end
