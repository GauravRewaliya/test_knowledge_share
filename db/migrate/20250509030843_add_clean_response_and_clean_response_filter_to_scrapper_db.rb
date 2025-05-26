class AddCleanResponseAndCleanResponseFilterToScrapperDb < ActiveRecord::Migration[8.0]
  def change
    add_column :scrapper_dbs, :clean_response, :json
    add_column :scrapper_dbs, :clean_response_filter, :json
  end
end
