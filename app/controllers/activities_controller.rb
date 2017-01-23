class ActivitiesController < ApplicationController

  def new
    referrer = Rails.application.routes.recognize_path(request.referrer)
    @save_and_return = referrer[:action] == 'show' ? true : false
    @logic_model = LogicModel.find(params[:logic_model_id])
    @activity = @logic_model.activities.new
  end

  def create
    @logic_model = LogicModel.find(params[:logic_model_id])
    @activity = @logic_model.activities.new(activity_params)
    @save_and_return = activity_params[:save_and_return]
    if (@save_and_return == "true") && @activity.save
      redirect_to logic_model_path(@activity.logic_model)
    elsif !(@save_and_return == "true") && @activity.save && params['commit']
      redirect_to activity_path(@activity)
    else
      render 'new'
    end
  end

  def show
    @activity = Activity.find(params[:id])
    @logic_model = @activity.logic_model
  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def update
    @activity = Activity.find(params[:id])
    if @activity.update(activity_params)
      redirect_to logic_model_path(@activity.logic_model)
    else
      render 'edit'
    end
  end

private

  def activity_params
    params.require(:activity).permit(:name, :description, :start_date, :end_date, :budget, :save_and_return)
  end
end