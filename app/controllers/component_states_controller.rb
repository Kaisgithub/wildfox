class ComponentStatesController < ApplicationController

  def index
    @component_states = ComponentState.all
    render json: @component_states
  end

  def create
    # @component_type = ComponentType.find_by_id(params[:id])
    # @component_state = @component_type.component_states.create(component_states_params)
    @component_state = ComponentState.new(component_states_params)
    if @component_state.save
      render json: @component_state, status: :created
    else
      render json: @component_state.errors, status: :unprocessable_entity
    end
  end

  def update
    @component_state = ComponentState.find_by_id(params[:id])
    if @component_state.update(component_states_params)
      render json: @component_state, status: :created
    else
      render json: @component_state.errors, status: :not_found
    end
  end

  def delete
    @component_state = ComponentState.find_by_id(params[:id])
    if @component_state.destroy
      render json: @component_state, status: :ok
    else
      render json: @component_state.errors, status: :not_found
    end
  end

  private
  def component_states_params
    params.require(:component_state).permit(:state_name, :component_type_id)
    # params.require(:component_state).permit(:state_name)
  end
end
