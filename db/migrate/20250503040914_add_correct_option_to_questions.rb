class AddCorrectOptionToQuestions < ActiveRecord::Migration[8.0]
  def change
    add_column :questions, :correct_option, :string
  end
end
