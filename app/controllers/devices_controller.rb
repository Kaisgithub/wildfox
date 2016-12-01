class DevicesController < ApplicationController
  def index
    @devices = Device.all
    render json: @devices
  end

  def show
    @device = Device.first
    jsonpath = xtoy(params[:jsonpath])
    path = JsonPath.new(jsonpath)
    value = path.on(@device.as_json)[0]
    obj = {'jsonvalue' => value}
    render json: obj
  end

  def create
    @device = Device.new()
    @device.devices = params[:devices]
    if @device.save!
      render json: @device, status: :created
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  def add
    @device = Device.first
    jsonpathd = devices_params['devices']['jsonpath']
    jsonvalue = devices_params['devices']['value']
    jsonpath = dtoy(jsonpathd)
    path = JsonPath.new(jsonpath)
    value = path.on(@device.as_json)[0]
    newjsonvalue = value.merge jsonvalue
    @devicenew = JsonPath.for(@device.as_json).gsub(jsonpath) {|v| newjsonvalue }.to_hash
    @device.update(@devicenew)
    render json: newjsonvalue
  end

  def alert
    @device = Device.first
    jsonpathd = devices_params['devices']['jsonpath']
    jsonvalue = devices_params['devices']['value']
    jsonpath = dtoy(jsonpathd)
    path = JsonPath.new(jsonpath)
    if path.on(@device.as_json)[0] == jsonvalue
      puts 'equal'
      render json: @device
    else
      puts 'different'
      @devicenew = JsonPath.for(@device.as_json).gsub(jsonpath) {|v| jsonvalue }.to_hash
      @device.update(@devicenew)

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

      render json: @device
    end
  end

  def delete
    @device = Device.first
    jsonpath = xtoy(params[:jsonpath])
    @devicenew = JsonPath.for(@device.as_json).delete(jsonpath).to_hash
    @device.update(@devicenew)
    render json: @device
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

  def devices_params
    params.permit(:devices).tap do |whitelisted|
      whitelisted[:devices] = params[:devices]
    end
  end

end
