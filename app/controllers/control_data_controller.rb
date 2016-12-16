class ControlDataController < ApplicationController

  def index
    @control_data = ControlDatum.all
    render json: @control_data
  end

  def create
    @data_nodes_id = params[:data_nodes_id]
    @data_node = DataNode.find_by_id(@data_nodes_id)

    data = params[:data].to_i
    @data_source = DataSource.find_by_id(@data_node.data_sources_id)
    con = ModBus::TCPClient.new(@data_source.describe['ip'], @data_source.describe['port'])
    con.with_slave(1) do |slave|
      slave.coils[@data_node.describe['offset']] = data
      @control_data = ControlDatum.new()
      @control_data.data_nodes_id = @data_node.id
      @control_data.data = data
      @control_data.save
    end
    render json: @control_data
  end

end
