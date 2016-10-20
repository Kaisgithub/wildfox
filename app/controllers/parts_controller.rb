class PartsController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def index
    json = '{"candy":"lollipop","noncandy":null,"other":"things"}'
    o = JsonPath.for(json).
        gsub('$..candy') {|v| "big turks" }.
        delete('$candy').
        to_hash
    puts o

    @parts = Part.all
    render json: @parts
  end


  def show
    # json = '{"candy":"lollipop"}'
    # json = JsonPath.for(json).gsub('$..candy') { |v| "big turks" }.to_hash
    # puts json

    @part = Part.find_by_id(params[:id])

    path = JsonPath.new("$['data']['components']")
    result = path.on(@part.as_json)
    print result[0]

    # render json: @part.data[0]['cps']
    # render json: @part['data'][0]['cps']
    render json: @part.data
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

  def update
    @part = Part.find_by_id(params[:id])
    parts_params['data'].each do |t|
      # puts 'aaaaaaaaaa', parts_params
      path = JsonPath.new(t[0])
      # puts 'olddata:', path.on(@part.as_json)
      # puts 'newdata:', t[1]
      if path.on(@part.as_json)[0] == t[1]
        puts 'equal'
      else
        puts 'different'
        @partnew = JsonPath.for(@part.as_json).gsub(t[0]) {|v| t[1] }.to_hash
        @part.update(@partnew)

        # obj = t[0] + ':' + t[1]
        obj = {t[0] => t[1]}
        objs = obj.to_s

        conn = Bunny.new(:automatically_recover => false)
        conn.start
        ch   = conn.create_channel
        q    = ch.queue("hello")
        ch.default_exchange.publish(objs, :routing_key => 'mymessages')
        puts obj
        conn.close
        render json: @part
        # conn = Bunny.new(
        #     :host => "192.168.4.175",
        #     :port => 5672,
        #     :ssl       => false,
        #     :vhost     => "/",
        #     :user      => "admin",
        #     :pass      => "admin",
        #     :heartbeat => :server, # will use RabbitMQ setting
        #     :frame_max => 131072,
        #     :auth_mechanism => "PLAIN"
        # )
        # conn.start
        #
        # ch   = conn.create_channel
        # q    = ch.queue("hello")
        #
        # ch.default_exchange.publish(objs, :routing_key => q.name)
        # conn.close

      end
    end

    # if @part.update!(parts_params)
    #   render json: @part, status: :ok
    # else
    #   render json: @part.errors, status: :not_found
    # end
  end


  private
  def parts_params
    params.permit(:data).tap do |whitelisted|
      whitelisted[:data] = params[:data]
    end
  end


  # def update
  #   @part = Part.find_by_id(params[:id])
  #   if @part.update!(parts_params)
  #     render json: @part, status: :ok
  #   else
  #     render json: @part.errors, status: :not_found
  #   end
  # end
  #
  # private
  # def parts_params
  #   params.permit(:data).tap do |whitelisted|
  #     whitelisted[:data] = params[:data]
  #   end
  # end

end

