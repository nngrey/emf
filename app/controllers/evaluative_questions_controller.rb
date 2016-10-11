class EvaluativeQuestionsController < ApplicationController

  def new
    @evaluative_question = EvaluativeQuestion.new
    @evaluative_question.sub_questions.build
  end

  def create
    @evaluative_question = EvaluativeQuestion.new(evaluative_question_params)
    if @evaluative_question.save
      redirect_to edit_evaluative_question_path(@evaluative_question)
    else
      @evaluative_question.sub_questions.build
      render "new"
    end
  end

  def edit
    @evaluative_question = EvaluativeQuestion.find(params[:id])
  end

  def update
    @evaluative_question = EvaluativeQuestion.find(params[:id])
    if @evaluative_question.update_attributes(evaluative_question_params)
      redirect_to evaluative_questions_path
    else
      render 'edit'
    end
  end

  def index
    @evaluative_questions = EvaluativeQuestion.all
  end

  private
  def evaluative_question_params
    params.require(:evaluative_question).permit(
      :category,
      :description,
      sub_questions_attributes:
      [
        :id,
        :description,
        :monitoring_information,
        :_destroy,
        performance_indicators_attributes:
        [
          :description,
          :definition,
          :numerator,
          :denominator,
          :numerator_label,
          :denominator_label,
          :_destroy
        ]
      ]
    )
  end
end