class ComponentTypesController < ApplicationController

  def index
    @component_types = ComponentType.all
    render json: @component_types
  end

  def create
    @component_type = ComponentType.new(component_types_params)
    if @component_type.save
      render json: @component_type, status: :created
    else
      render json: @component_type.errors, status: :unprocessable_entity
    end
  end

  def update
    @component_type = ComponentType.find_by_id(params[:id])
    if @component_type.update(component_types_params)
      render json: @component_type, status: :created
    else
      render json: @component_type.errors, status: :not_found
    end
  end

  def delete
    @component_type = ComponentType.find_by_id(params[:id])
    if @component_type.destroy
      render json: @component_type, status: :ok
    else
      render json: @component_type.errors, status: :not_found
    end
  end

  private
  def component_types_params
    the_params = params.require(:component_type).permit(:typename)
  end
end
