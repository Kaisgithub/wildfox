class DataNodesController < ApplicationController

  def index
    @data_nodes = DataNode.all
    render json: @data_nodes
  end

  def create
    @data_node = DataNode.new()
    @data_node.data_sources_id = params[:data_sources_id]
    @data_node.name = params[:name]
    @data_node.describe = params[:describe]
    if @data_node.save!
      render json: @data_node, status: :created
    else
      render json: @data_node.errors, status: :unprocessable_entity
    end
  end

  def alert
    @data_node = DataNode.find_by_name(params[:name])
    jsonpathd = params['jsonpath']
    jsonvalue = params['value']
    jsonpath = dtoy(jsonpathd)
    path = JsonPath.new(jsonpath)
    if path.on(@data_node.as_json)[0] == jsonvalue
      puts 'equal'
      render json: @data_node
    else
      puts 'different'
      @data_nodenew = JsonPath.for(@data_node.as_json).gsub(jsonpath) {|v| jsonvalue }.to_hash
      @data_node.update(@data_nodenew)

      render json: @data_node
    end
  end

end
