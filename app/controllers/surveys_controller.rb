class SurveysController < ApplicationController

  helper_method :valid_json?

  def new
    @survey_template = SurveyTemplate.find(params[:survey_template_id])
    @survey = @survey_template.surveys.build
    @survey_template.data_questions.each do |question|
      @survey.survey_questions.build(data_question_id: question.id, description: question.description, question_type: question.question_type, multiple_answers: question.multiple_answers)
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
    if @survey.save(survey_params) && create_survey_responses
      redirect_to survey_template_survey_path(@survey_template, @survey)
    else
      # flash
      render new
    end
  end

  def show
    @survey_template = SurveyTemplate.find(params[:survey_template_id])
    @survey = Survey.find(params[:id])
  end

  def edit
    @survey = Survey.find(params[:id])
  end

  def valid_json?(json)
    begin
      JSON.parse(json)
      return true
    rescue JSON::ParserError => e
      return false
    end
  end

  private

  def survey_params
    params.require(:survey).permit(
      survey_questions_attributes: [:id,
        survey_responses:[:id, :data_question_id, :input_value, input_value: []]]
    )
  end

  def create_survey_responses
    survey_params[:survey_questions_attributes].each do |k, v|
      data_question_id = v[:survey_responses][:data_question_id]
      survey_question = @survey.survey_questions.find_by(data_question_id: data_question_id)
      attrs = v[:survey_responses].each {|k,v| {k: v}}
      attrs[:input_value].reject!(&:empty?).collect(&:strip!) if attrs[:input_value].kind_of?(Array)
      survey_question.survey_responses.create(attrs)
    end
  end

  def update_survey_responses
    survey_params[:survey_questions_attributes].each do |k, v|
      data_question_id = v[:survey_responses][:data_question_id]
      survey_question = SurveyQuestion.find_by(data_question_id: data_question_id)
      response = survey_question.survey_responses.create(v[:survey_responses])
      response
    end
  end
end