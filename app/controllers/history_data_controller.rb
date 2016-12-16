class HistoryDataController < ApplicationController
  def index
    @history_data = HistoryDatum.all
    render json: @history_data
  end

  def show
    @describe = params[:describe]
    @number = params[:number]
    @history_data = HistoryDatum.where(describe: @describe)
    render json: @history_data.last(@number)
  end


end
