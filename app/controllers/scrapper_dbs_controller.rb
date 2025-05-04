class ScrapperDbsController < ApplicationController
  def index
    # Fetch all database records (replace with your actual DB query)
    @records = ScrapperDb.all
  end

  # def show
  #   # Fetch a single record (you might want to fetch the associated response here)
  #   @record = ScrapperDb.find(params[:id])
  # end
end

