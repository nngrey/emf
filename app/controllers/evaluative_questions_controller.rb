class EvaluativeQuestionsController < ApplicationController

  # def index
  #   @view_as = params[:view_as] || 'list'
  #   @evaluative_questions = EvaluativeQuestion.all
  # end

  def show
    @view_as = params[:view_as] || 'list'
    @evaluative_question = EvaluativeQuestion.find(params[:id])
  end

  def new
    @framework = Framework.find(params[:framework_id]) if params[:framework_id]
    @evaluative_question = EvaluativeQuestion.new(framework: @framework)
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
    @evaluative_question.sub_questions.each do |sub_question|
      @performance_indicator = sub_question.performance_indicators.build
    end
  end

  def update
    @evaluative_question = EvaluativeQuestion.find(params[:id])
    if @evaluative_question.update_attributes(evaluative_question_params)
      redirect_to evaluative_question_path(@evaluative_question)
    else
      @evaluative_question.sub_questions.each do |sub_question|
        if sub_question.errors[:performance_indicators].first == "can't be blank"
          @performance_indicator = sub_question.performance_indicators.build
        end
      end
      render 'edit'
    end
  end

  private
  def evaluative_question_params
    params.require(:evaluative_question).permit(
      :category,
      :description,
      :framework_id,
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