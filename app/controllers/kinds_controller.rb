class KindsController < ApplicationController
  def index
    @kinds = Kind.all
    render json: @kinds
  end

  def show
    if params[:describe].blank?
      @kind = Kind.find_by_id(params[:id])
      render json: @kind
    else
      @kind = Kind.where('kindname = ?', params[:describe])
      render json: @kind
    end
  end

  def create
    @kind = Kind.new(kinds_params)
    if @kind.save
      render json: @kind, status: :created
    else
      render json: @kind.errors, status: :unprocessable_entity
    end
  end

  def update
    @kind = Kind.find_by_id(params[:id])
    if @kind.update(kinds_params)
      render json: @kind, status: :created
    else
      render json: @kind.errors, status: :not_found
    end
  end

  def delete
    @kind = Kind.find_by_id(params[:id])
    if @kind.destroy
      render json: @kind, status: :ok
    else
      render json: @kind.errors, status: :not_found
    end
  end

  private
  def kinds_params
    the_params = params.require(:kind).permit(:kindname)
  end
end
