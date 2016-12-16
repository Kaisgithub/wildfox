class StateDataController < ApplicationController

  def index
    @state_data = StateDatum.all
    render json: @state_data
  end

  def show
    @data_nodes_id = params[:data_nodes_id]
    @state_data = StateDatum.where(data_nodes_id: @data_nodes_id)
    render json: @state_data
  end

  def create

    @data_sources_id = params[:data_sources_id]
    @data_source = DataSource.find_by_id(@data_sources_id)
    @data_source.state = 'on'
    @data_source.save

    if @data_source.state == 'on'
      con = ModBus::TCPClient.new(@data_source.describe['ip'], @data_source.describe['port'])
      con.with_slave(1) do |slave|

        Thread.new{
          while @data_source.state == 'on' do
            @data_nodes = DataNode.where(data_sources_id: @data_sources_id)
            @data_nodes.each do |i|
              data = slave.coils[i.describe['offset']].first
              @state_data = StateDatum.new()
              @state_data.data_nodes_id = i.id
              @state_data.data = data
              @state_data.save
            end

            sleep(@data_source.describe['update_time'])
            @data_source = DataSource.find_by_id(@data_sources_id)
          end
          con.close
          puts 'Thread end'
        }

      end
    end

    render json: @data_source
  end


end
