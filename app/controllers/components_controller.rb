class ComponentsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @components = Component.all
    respond_to do |format|
      format.html
      format.json {render json: @components}
    end
  end

  def show
    if params[:describe].blank?
      @component = Component.find_by(id: params[:id])
      render json: @component
    else
      #@component = Component.find_by(describe: params[:describe])
      @component = Component.where('describe = ?', params[:describe])
      render json: @component
    end
  end

  def create
    @component = Component.new(components_params)
    respond_to do |format|
      if @component.save
        format.json {render json: @component, status: :created}
      else
        format.json {render json: @component.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    @component = Component.find_by_id(params[:id])
    if @component.update(components_params)
      render json: @component, status: :ok
    else
      render json: @component.errors, status: :not_found
    end
  end

  def delete
    @component = Component.find_by_id(params[:id])
    if @component.destroy
      render json: @component, status: :ok
    else
      render json: @component, status: :not_found
    end
  end


  private
  def components_params
    the_params = params.require(:component).permit(:describe, :struct)
  end
end
