class ModesController < ApplicationController
  def index
    @kind = Kind.find(params[:kind_id])
    @modes = @kind.modes.all
    render json: @modes
  end

  def show
    @kind = Kind.find(params[:kind_id])
    @mode = @kind.modes.find_by_id(params[:id])
    render json: @mode
  end

  def create
    @kind = Kind.find(params[:kind_id])
    @mode = @kind.modes.create(modes_params)
    if @mode.save
      render json: @mode, status: :created
    else
      render json: @mode.errors, status: :unprocessable_entity
    end
  end

  def update
    @kind = Kind.find(params[:kind_id])
    @mode = Mode.find_by_id(params[:id])
    if @mode.update(modes_params)
      render json: @mode, status: :created
    else
      render json: @mode.errors, status: :not_found
    end
  end

  def delete
    @mode = Mode.find_by_id(params[:id])
    if @mode.destroy
      render json: @mode, status: :ok
    else
      render json: @mode.errors, status: :not_found
    end
  end

  private
  def modes_params
    the_params = params.require(:mode).permit(:modename)
  end
end
