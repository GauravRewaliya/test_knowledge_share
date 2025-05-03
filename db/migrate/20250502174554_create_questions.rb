class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.string :content
      t.json :meta_data
      t.json :options
      t.string :tags

      t.timestamps
    end
  end
end
