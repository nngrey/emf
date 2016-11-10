class SurveysController < ApplicationController

  def new
    @survey = Survey.new
    @survey_template = SurveyTemplate.find(params[:survey_template_id])
  end

  def create
    binding.pry
  end

end