class DataSourcesController < ApplicationController
  def index
    @data_sources = DataSource.all
    render json: @data_sources
  end

  def show
    if params[:jsonpath].blank?
      @data_source = DataSource.find_by_describe(params[:describe])
      render json: @data_source
    else
      @data_source = DataSource.find_by_describe(params[:describe])
      jsonpath = xtoy(params[:jsonpath])
      path = JsonPath.new(jsonpath)
      value = path.on(@data_source.as_json)[0]
      obj = {'jsonvalue' => value}
      render json: obj
    end
  end

  def create
    @data_source = DataSource.new()
    @data_source.name = params[:name]
    @data_source.genre = params[:genre]
    @data_source.state = params[:state]
    @data_source.describe = params[:describe]
    if @data_source.save!
      render json: @data_source, status: :created
    else
      render json: @data_source.errors, status: :unprocessable_entity
    end
  end

  def add
    @datasource = DataSource.find_by_describe(params[:describe])
    jsonpathd = datasources_params['datasources']['jsonpath']
    jsonvalue = datasources_params['datasources']['value']
    jsonpath = dtoy(jsonpathd)
    path = JsonPath.new(jsonpath)
    value = path.on(@datasource.as_json)[0]
    newjsonvalue = value.merge jsonvalue
    @datasourcenew = JsonPath.for(@datasource.as_json).gsub(jsonpath) {|v| newjsonvalue }.to_hash
    @datasource.update(@datasourcenew)
    render json: newjsonvalue
  end

  def alert
    @data_source = DataSource.find_by_name(params[:name])
    jsonpathd = params['jsonpath']
    jsonvalue = params['value']
    jsonpath = dtoy(jsonpathd)
    path = JsonPath.new(jsonpath)
    if path.on(@data_source.as_json)[0] == jsonvalue
      puts 'equal'
      render json: @data_source
    else
      puts 'different'
      @data_sourcenew = JsonPath.for(@data_source.as_json).gsub(jsonpath) {|v| jsonvalue }.to_hash
      @data_source.update(@data_sourcenew)

      render json: @data_source
    end
  end

  def delete
    if params[:jsonpath].blank?
      @datasource = DataSource.find_by_describe(params[:describe])
      @datasource.destroy
      render json: @datasource
    else
      @datasource = DataSource.find_by_describe(params[:describe])
      jsonpath = xtoy(params[:jsonpath])
      @datasourcenew = JsonPath.for(@datasource.as_json).delete(jsonpath).to_hash
      @datasource.update(@datasourcenew)
      render json: @datasource
    end
  end

end
