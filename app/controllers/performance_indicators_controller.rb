class PerformanceIndicatorsController < ApplicationController

  def index
    @evaluative_questions = EvaluativeQuestion.all
  end

  def edit
    @performance_indicator = PerformanceIndicator.find(params[:id])
  end

  def update
    @performance_indicator = PerformanceIndicator.find(params[:id])
    if @performance_indicator.update_attributes(performance_indicator_params)
      redirect_to performance_indicators_path
    else
      render 'edit'
    end
  end

  private
  def performance_indicator_params
    params.require(:performance_indicator).permit(:numerator, :denominator)
  end
end