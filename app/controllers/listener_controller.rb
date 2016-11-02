class ListenerController < ApplicationController
  def index
    render 'listener/listener'
  end

  def show
    render 'listener/index'
  end
end
