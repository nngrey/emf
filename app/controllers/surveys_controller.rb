class SurveysController < ApplicationController

  def new
    @survey_template = SurveyTemplate.find(params[:survey_template_id])
    @survey = @survey_template.surveys.build
    @survey_template.data_questions.each do |question|
      @survey.survey_questions.build(data_question_id: question.id, description: question.description, question_type: question.question_type)
    end
    @survey.survey_questions.each do |question|
      question.survey_responses.build
    end
  end

  def create
    @survey_template = SurveyTemplate.find(params[:survey_template_id])
    @survey = @survey_template.surveys.build
    @survey_template.data_questions.each do |question|
      @survey.survey_questions.build(data_question_id: question.id, description: question.description, question_type: question.question_type)
    end
    if @survey.save(survey_params)&& create_survey_responses
      redirect_to survey_template_survey_path(@survey_template, @survey)
    else
      # flash
      render new
    end
  end

  def show
    @survey = Survey.find(params[:id])
  end

  private

  def survey_params
    params.require(:survey).permit(
      survey_questions_attributes: [:id,
        survey_responses:[:input_value, :data_question_id]]
    )
  end

  def create_survey_responses
    survey_params[:survey_questions_attributes].each do |k, v|
      data_question_id = v[:survey_responses][:data_question_id]
      survey_question = SurveyQuestion.find_by(data_question_id: data_question_id)
      survey_question.survey_responses.create(v[:survey_responses])
    end
  end


end