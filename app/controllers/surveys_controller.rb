class SurveysController < ApplicationController

  def new
    @survey_template = SurveyTemplate.find(params[:survey_template_id])
    @survey = @survey_template.surveys.build
    @survey_template.data_questions.each do |question|
      @survey.survey_questions.build(data_question_id: question.id, description: question.description, question_type: question.question_type)
    end
  end

  def create
  end

end