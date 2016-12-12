class LogicModelsController < ApplicationController

  def new
    @program = Program.find(params[:program_id])
    @logic_model = @program.build_logic_model
    @logic_model_input = @logic_model.logic_model_inputs.new
    @activity = @logic_model.activities.new
    @output = @logic_model.outputs.new
    @outcome = @logic_model.outcomes.new
    @impact = @logic_model.impacts.new
  end

  def create
    @program = Program.find(params[:program_id])
    @logic_model = @program.build_logic_model(logic_model_params)
    if @logic_model.save
      redirect_to logic_model_path(@logic_model)
    else
      render "new"
    end
  end

  def show
    @logic_model = LogicModel.find(params[:id])
  end

  def logic_model_params
    params.require(:logic_model).permit(
      logic_model_inputs_attributes:
        [:id, :description],
      activities_attributes:
        [:id, :description],
      outputs_attributes:
        [:id, :description],
      outcomes_attributes:
        [:id, :description],
      impacts_attributes:
        [:id, :description],
    )
  end

end