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
    if @data_question.save #&& (params['commit'] == "Add another question")
      @data_question.build_options
      redirect_to data_question_path(@data_question)
    #   redirect_to new_survey_template_data_question_path(@survey_template)
    # elsif params['commit'] == "Finish"
    #   @data_question.save
    #   @data_question.build_options
    #   redirect_to survey_template_path(@survey_template)
    else
      @evaluative_questions = @survey_template.framework.evaluative_questions
      render "new"
    end
  end

  def edit
    @data_question = DataQuestion.find(params[:id])
    if @data_question.performance_indicator.present?
      @performance_indicator_id = @data_question.performance_indicator.id
    else
      @performance_indicator_id = ''
    end
    @options = @data_question.options
    @survey_template = @data_question.survey_template
    @evaluative_questions = @survey_template.framework.evaluative_questions
  end

  def update
    @data_question = DataQuestion.find(params[:id])
    @survey_template = @data_question.survey_template
    if params[:display_value].present?
      @data_question.update(display_value: params[:display_value])
    elsif @data_question.update(data_question_params)
      @data_question.build_options
      redirect_to survey_template_path(@survey_template)
    else
      @options = @data_question.options
      @evaluative_questions = @survey_template.framework.evaluative_questions
      render 'edit'
    end
  end

  def show
    @data_question = DataQuestion.find(params[:id])

    @options
  end

  def sort
    params[:question].each_with_index do | id, index |
      DataQuestion.find(id).update(position: index + 1)
    end
  end

  private

  def data_question_params
    params.require(:data_question).permit(
      :id,
      :description,
      :question_type,
      :multiple_answers,
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
