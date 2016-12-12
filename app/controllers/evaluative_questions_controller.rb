class EvaluativeQuestionsController < ApplicationController

  def show
    @view_as = params[:view_as] || 'list'
    @evaluative_question = EvaluativeQuestion.find(params[:id])
  end

  def new
    if params[:program_id]
      @program = Program.find(params[:program_id])
      @evaluative_question = @program.framework.evaluative_questions.new
    elsif params[:framework_id]
      @framework = Framework.find(params[:framework_id])
      @program = @framework.program
      @evaluative_question = @framework.evaluative_questions.new
    end
    @evaluative_question.performance_indicators.build
  end

  def create
    @framework = Framework.find(params[:framework_id])
    @evaluative_question = @framework.evaluative_questions.new(evaluative_question_params)
    if @evaluative_question.save
      redirect_to evaluative_question_path(@evaluative_question)
    else
      if @evaluative_question.performance_indicators.blank?
        @evaluative_question.performance_indicators.build
      end
      render "new"
    end
  end

  def edit
    @evaluative_question = EvaluativeQuestion.find(params[:id])
    @framework = @evaluative_question.framework
  end

  def update
    @evaluative_question = EvaluativeQuestion.find(params[:id])
    if @evaluative_question.update_attributes(evaluative_question_params)
      redirect_to evaluative_question_path(@evaluative_question)
    else
      render 'edit'
    end
  end

  private
  def evaluative_question_params
    params.require(:evaluative_question).permit(
      :category,
      :description,
      :framework_id,
      performance_indicators_attributes:
      [
        :id,
        :description,
        :definition,
        :_destroy
      ]
    )
  end
end