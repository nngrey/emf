class ActivitiesController < ApplicationController

  def new
    @logic_model = LogicModel.find(params[:logic_model_id])
    @activity = @logic_model.activities.new
  end

  def create
    @logic_model = LogicModel.find(params[:logic_model_id])
    @activity = @logic_model.activities.new(activity_params)
    if @activity.save && params['commit'] == "Add another activity"
      redirect_to new_logic_model_activity_path(@logic_model)
    elsif @activity.save && params['commit'] == "Save and continue"
      redirect_to new_outputs_logic_model_path(@logic_model)
    else
      render 'new'
    end
  end

private

  def activity_params
    params.require(:activity).permit(:name, :description, :start_date, :end_date, :budget)
  end
end