class SurveysController < ApplicationController

  def new
    @survey_template = SurveyTemplate.find(params[:survey_template_id])
    @survey = @survey_template.surveys.build
    @survey_template.data_questions.each do |question|
      @survey.survey_questions.build(data_question_id: question.id, description: question.description, question_type: question.question_type)
    end
    @survey.survey_questions.each do |question|
      question.correct_answers.build
    end
  end

  def create
    @survey_template = SurveyTemplate.find(params[:survey_template_id])
    @survey = @survey_template.surveys.build
    @survey_template.data_questions.each do |question|
      @survey.survey_questions.build(data_question_id: question.id, description: question.description, question_type: question.question_type)
    end
    if @survey.save(survey_params)&& create_correct_answers
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
        correct_answers:[:input_value, :data_question_id]]
    )
  end

  def create_correct_answers
    survey_params[:survey_questions_attributes].each do |k, v|
      data_question_id = v[:correct_answers][:data_question_id]
      survey_question = SurveyQuestion.find_by(data_question_id: data_question_id)
      survey_question.correct_answers.create(v[:correct_answers])
    end
  end


end