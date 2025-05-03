class CreateScrapperDbs < ActiveRecord::Migration[8.0]
  def change
    create_table :scrapper_dbs do |t|
      t.string :url
      t.json :meta_data
      t.string :source_provider
      t.string :sub_type
      t.json :response
      t.string :parser_info
      t.json :filtered_data
      t.json :extra_data

      t.timestamps
    end
  end
end
