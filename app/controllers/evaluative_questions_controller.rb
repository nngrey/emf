class EvaluativeQuestionsController < ApplicationController

  def new
    @evaluative_question = EvaluativeQuestion.new
  end

  def create
    @evaluative_question = EvaluativeQuestion.new(evaluative_question_params)
    if @evaluative_question.save
      redirect_to @evaluative_question
    else
      render "new"
    end
  end

  def show
    @evaluative_question = EvaluativeQuestion.find(params[:id])
  end

  private
  def evaluative_question_params
    params.require(:evaluative_question).permit(
      :category,
      :description,
      sub_questions_attributes: [:description, :monitoring_information, :_destroy]
      )
  end
end