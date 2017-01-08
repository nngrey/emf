class ActivitiesController < ApplicationController

  def new
    @logic_model = LogicModel.find(params[:logic_model_id])
    @activity = @logic_model.activities.new
  end

  def create
    @logic_model = LogicModel.find(params[:logic_model_id])
    @activity = @logic_model.activities.new(activity_params)
    if @activity.save && params['commit'] == "Save and continue"
      redirect_to activity_path(@activity)
    else
      render 'new'
    end
  end

  def show
    @activity = Activity.find(params[:id])
    @logic_model = @activity.logic_model
  end

private

  def activity_params
    params.require(:activity).permit(:name, :description, :start_date, :end_date, :budget)
  end
end