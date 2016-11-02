class PartsController < ApplicationController

  def index
    @parts = Part.all
    render json: @parts
  end

  def show
    @parts = Part.first
    jsonpath = xtoy(params[:jsonpath])
    path = JsonPath.new(jsonpath)
    value = path.on(@parts.as_json)[0]
    obj = {'jsonvalue' => value}
    render json: obj
  end

  def create
    @part = Part.new()
    @part.data = params[:data]
    if @part.save!
      render json: @part, status: :created
    else
      render json: @part.errors, status: :unprocessable_entity
    end
  end

  def add
    @part = Part.first
    jsonpathd = parts_params['data']['jsonpath']
    jsonvalue = parts_params['data']['value']
    jsonpath = dtoy(jsonpathd)
    path = JsonPath.new(jsonpath)
    value = path.on(@part.as_json)[0]
    newjsonvalue = value.merge jsonvalue
    @partnew = JsonPath.for(@part.as_json).gsub(jsonpath) {|v| newjsonvalue }.to_hash
    @part.update(@partnew)
    render json: newjsonvalue
  end

  def alert
    @part = Part.first
    jsonpathd = parts_params['data']['jsonpath']
    jsonvalue = parts_params['data']['value']
    jsonpath = dtoy(jsonpathd)
    path = JsonPath.new(jsonpath)
    if path.on(@part.as_json)[0] == jsonvalue
      puts 'equal'
      render json: @part
    else
      puts 'different'
      @partnew = JsonPath.for(@part.as_json).gsub(jsonpath) {|v| jsonvalue }.to_hash
      @part.update(@partnew)

      obj = {jsonpathd => jsonvalue}
      objs = jtom(obj.to_s)
      conn = Bunny.new(
          :host => "192.168.4.175",
          :port => 5672,
          :ssl       => false,
          :vhost     => "/",
          :user      => "admin",
          :pass      => "admin",
          :heartbeat => :server, # will use RabbitMQ setting
          :frame_max => 131072,
          :auth_mechanism => "PLAIN"
      )
      conn.start
      ch   = conn.create_channel
      x    = ch.topic("amq.topic")
      x.publish(objs, :routing_key => jsonpathd)
      conn.close
      render json: @part
    end
  end

  def delete
    @part = Part.first
    jsonpath = xtoy(params[:jsonpath])
    @partnew = JsonPath.for(@part.as_json).delete(jsonpath).to_hash
    @part.update(@partnew)
    render json: @part
  end

  private

  def xtoy(s)
    objs = "['" + s + "']"
    while (objs["_"])
      objs["_"] = "']['"
    end
    return objs
  end

  def dtoy(s)
    objs = "['" + s + "']"
    while (objs["."])
      objs["."] = "']['"
    end
    return objs
  end

  def jtom(s)
    while (s["\"=>"])
      s["\"=>"] = "\":"
    end
    return s
  end

  def parts_params
    params.permit(:data).tap do |whitelisted|
      whitelisted[:data] = params[:data]
    end
  end


end

