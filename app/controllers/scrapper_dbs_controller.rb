class ScrapperDbsController < ApplicationController
  def index
    # Fetch all database records (replace with your actual DB query)
    @records = ScrapperDb.all
  end

  def response_basic_filter_refresh
    @records = ScrapperDb.where(id: params[:ids])
    @records.each do |record|
      record.fetch_basic_filter
    end
    @records.save
  end
  def test_request
    @record = ScrapperDb.find(params[:id])
    response = @record.call_live_request
    render json: response
  end
  # must conform first before update
  def update_response
    @record = ScrapperDb.find(params[:id])
    @record.update(response: params[:response])
    @record.basic_filter_apply
    @record.save
  end

  def look_har_file
    file = params[:file]
    mock_data = [
      3.times.each do |i|
      {
        "url": "https://www.example.com",
        "meta_data": {
          "method": "GET",
          "headers": {},
          "body": {},
          "url": "https://www.example.com"
        },
        "source_provider": "testbook",
        "sub_type": "testbook_subject_chapters",
        "response": {},
        "parser_info": {},
        "filtered_data": {},
        "extra_data": {
          "via": "har_file"
        },
        "status": "need_to_fetch"
      }
      end
    ]
  end
  def save_selected_data_from_har
    # file = params[:file] orignal files
    insert_data = params[:insert_data]
    # with basic filter data
    ScrapperDb.insert(insert_data)
  end
  def show_processed_response_with_basic_filter
    @record = ScrapperDb.find(params[:id])
    @filtered_data = @record.filtered_data
    respond_to do |format|
      format.html {  }
      format.json { render json: @filtered_data }
    end
  end

  # curd AiFilter
  def ai_filtered_data_create
    @record = ScrapperDb.find(params[:id])
    response = ServiceAi::ai::scrapper_ai.get_cleaner_json_formate.process(@record.filtered_data)
    @record.ai_filtered_data = response
    @record.save
    respond_to do |format|
      format.html {  }
      format.json { render json: response }
    end
  end
  def ai_filtered_data_update
    @record = ScrapperDb.find(params[:id])
    @record.ai_filtered_data = params[:ai_filtered_data]
    @record.save
    respond_to do |format|
      format.html {  }
      format.json { render json: @record.ai_filtered_data }
    end
  end
  def ai_filtered_data_destroy
    @record = ScrapperDb.find(params[:id])
    @record.ai_filtered_data = nil
    @record.save
    respond_to do |format|
      format.html {  }
      format.json { render json: @record.ai_filtered_data }
    end
  end
end

