class EvaluativeQuestionsController < ApplicationController

  def show
    @view_as = params[:view_as] || 'list'
    @evaluative_question = EvaluativeQuestion.find(params[:id])
  end

  def new
    @framework = Framework.find(params[:framework_id]) if params[:framework_id]
    @evaluative_question = EvaluativeQuestion.new(framework: @framework)
    # @evaluative_question.sub_questions.build
    @evaluative_question.performance_indicators.build
  end

  def create
    @evaluative_question = EvaluativeQuestion.new(evaluative_question_params)
    if @evaluative_question.save
      redirect_to evaluative_question_path(@evaluative_question)
    else
      @evaluative_question.performance_indicators.build
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
      redirect_to edit_performance_indicators_evaluative_question_path(@evaluative_question)
    else
      render 'edit'
    end
  end

  def edit_performance_indicators
    @evaluative_question = EvaluativeQuestion.find(params[:id])
    if @evaluative_question.sub_questions.map { |q| q.performance_indicators }.flatten.empty?
      @evaluative_question.sub_questions.each do |sub_question|
        @performance_indicator = sub_question.performance_indicators.build
        # @data_question = @performance_indicator.data_questions.build
        # @option = @data_question.options.build
      end
    end
  end

  def update_performance_indicators
    @evaluative_question = EvaluativeQuestion.find(params[:id])
    if @evaluative_question.update_attributes(evaluative_question_params)
      redirect_to evaluative_question_path(@evaluative_question)
    else
      @evaluative_question.sub_questions.each do |sub_question|
        if sub_question.errors[:performance_indicators].first == "can't be blank"
          @performance_indicator = sub_question.performance_indicators.build
        end
      end
      render 'edit_performance_indicators'
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
        :_destroy,
        data_questions_attributes:
        [
          :id,
          :description,
          :question_type,
          :_destroy,
          options_attributes:
          [
            :id,
            :description,
            :_destroy
          ]
        ]
      ]
    )
  end
end