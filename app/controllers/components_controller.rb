class ComponentsController < ApplicationController
  def index
    @components = Component.all
    render json: @components
  end

  def show
    @component = Component.first
    jsonpath = xtoy(params[:jsonpath])
    path = JsonPath.new(jsonpath)
    value = path.on(@component.as_json)[0]
    obj = {'jsonvalue' => value}
    render json: obj
  end

  def create
    @component = Component.new()
    @component.components = params[:components]
    if @component.save!
      render json: @component, status: :created
    else
      render json: @component.errors, status: :unprocessable_entity
    end
  end

  def add
    @component = Component.first
    jsonpathd = components_params['components']['jsonpath']
    jsonvalue = components_params['components']['value']
    jsonpath = dtoy(jsonpathd)
    path = JsonPath.new(jsonpath)
    value = path.on(@component.as_json)[0]
    newjsonvalue = value.merge jsonvalue
    @componentnew = JsonPath.for(@component.as_json).gsub(jsonpath) {|v| newjsonvalue }.to_hash
    @component.update(@componentnew)
    render json: newjsonvalue
  end

  def alert
    @component = Component.first
    jsonpathd = components_params['components']['jsonpath']
    jsonvalue = components_params['components']['value']
    jsonpath = dtoy(jsonpathd)
    path = JsonPath.new(jsonpath)
    if path.on(@component.as_json)[0] == jsonvalue
      puts 'equal'
      render json: @component
    else
      puts 'different'
      @componentnew = JsonPath.for(@component.as_json).gsub(jsonpath) {|v| jsonvalue }.to_hash
      @component.update(@componentnew)

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
      render json: @component
    end
  end

  def delete
    @component = Component.first
    jsonpath = xtoy(params[:jsonpath])
    @componentnew = JsonPath.for(@component.as_json).delete(jsonpath).to_hash
    @component.update(@componentnew)
    render json: @component
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

  def components_params
    params.permit(:components).tap do |whitelisted|
      whitelisted[:components] = params[:components]
    end
  end

end
