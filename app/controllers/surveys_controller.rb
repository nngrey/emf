class SurveysController < ApplicationController

  helper_method :valid_json?

  def new
    @survey_template = SurveyTemplate.find(params[:survey_template_id])
    @survey = @survey_template.surveys.build
  end

  def create
    @survey_template = SurveyTemplate.find(params[:survey_template_id])
    @survey = @survey_template.surveys.build
    @survey.data_questions = @survey_template.data_questions.dup
    if @survey.save && create_survey_responses
      redirect_to survey_template_survey_path(@survey_template, @survey)
    else
      flash.now[:error] = "The survey could not be saved because it was missing values."
      @survey = @survey_template.surveys.build
      render "surveys/new"
    end
  end

  def show
    @survey_template = SurveyTemplate.find(params[:survey_template_id])
    @survey = Survey.find(params[:id])
    @responses = @survey.survey_responses
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
      data_questions_attributes: [:id,
        survey_responses:[:id, :input_value, input_value: []]]
    )
  end

  def create_survey_responses
    if survey_params[:data_questions_attributes].to_h.map {|k, v| v.keys.include? "survey_responses" }.all?
      survey_params[:data_questions_attributes].each do |k, v|
        data_question_id = v[:id]
        data_question = @survey.data_questions.find(data_question_id)
        attrs = v[:survey_responses].each {|k,v| {k: v}}
        attrs[:input_value].reject!(&:empty?).collect(&:strip!) if attrs[:input_value].kind_of?(Array)
        attrs[:survey_id] = @survey.id
        data_question.survey_responses.create(attrs)
      end
    end
  end

  ##TODO is this an option?
  # def update_survey_responses
  #   survey_params[:survey_questions_attributes].each do |k, v|
  #     data_question_id = v[:survey_responses][:data_question_id]
  #     survey_question = SurveyQuestion.find_by(data_question_id: data_question_id)
  #     response = survey_question.survey_responses.create(v[:survey_responses])
  #     response
  #   end
  # end
end
