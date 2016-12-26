class DataQuestionsController < ApplicationController
  def new
    @survey_template = SurveyTemplate.find(params[:survey_template_id])
    @evaluative_questions = @survey_template.framework.evaluative_questions
    @data_question = @survey_template.data_questions.new
    @option = @data_question.options.build
  end

  def create
    @survey_template = SurveyTemplate.find(params[:survey_template_id])
    @data_question = @survey_template.data_questions.new(data_question_params)
    if @data_question.save && (params['commit'] == "Add another question")
      @data_question.build_options
      redirect_to new_survey_template_data_question_path(@survey_template)
    elsif params['commit'] == "Finish"
      @data_question.save
      @data_question.build_options
      redirect_to survey_template_path(@survey_template)
    else
      @evaluative_questions = @survey_template.framework.evaluative_questions
      render "new"
    end
  end

  def update
    @data_question = DataQuestion.find(params[:id])
    @data_question.update(display_value: params[:display_value])
  end

  private

  def data_question_params
    params.require(:data_question).permit(
      :id,
      :description,
      :question_type,
      :performance_indicator_id,
      :_destroy,
      options_attributes:
      [
        :id,
        :description,
        :_destroy,
      ]
    )
  end
end
