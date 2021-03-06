class EvaluativeQuestionsController < ApplicationController

  def new
    @framework = Framework.find(params[:framework_id])
    @program = @framework.program
    @category = @program.correct_category(params[:current_category], params[:step])
    @question_hints = @program.question_hints(@category)
    @indicator_hints = @program.indicator_hints(@category)
    @button_text = @category == 'sustainability' ? 'Finish' : 'Save and continue'
    @date_errors = []
    if params[:commit] == 'Finish'
      redirect_to framework_path(@program.framework)
    else
      @evaluative_question = @program.framework.evaluative_questions.new
      @performance_indicator = @evaluative_question.performance_indicators.build
      @performance_indicator.collection_dates.build
    end
  end

  def create
    ##TODO refactor like update
    @framework = Framework.find(params[:framework_id])
    @program = @framework.program
    @category = evaluative_question_params[:category]
    step = params['commit']
    @evaluative_question = @framework.evaluative_questions.new(evaluative_question_params)
    if @evaluative_question.save && step != 'Finish'
      redirect_to evaluative_question_path(@evaluative_question)
    elsif @evaluative_question.save && step == 'Finish'
      redirect_to framework_path(@framework)
    else
      if @evaluative_question.performance_indicators.blank?
        performance_indicator = @evaluative_question.performance_indicators.build
        performance_indicator.collection_dates.build
      else
        @evaluative_question.performance_indicators.each do |indicator|
          if indicator.collection_dates.blank?
            indicator.collection_dates.build
          end
        end
      end
      @date_errors = []
      if @evaluative_question.errors["performance_indicators.collection_dates"].any?
        @date_errors = @evaluative_question.errors["performance_indicators.collection_dates"]
      end
      render action: "new"
    end
  end

  def show
    @evaluative_question = EvaluativeQuestion.find(params[:id])
    @framework = @evaluative_question.framework
    @button_text = @evaluative_question.category == 'sustainability' ? 'Finish' : 'Continue'
  end

  def edit
    @date_errors = []
    @evaluative_question = EvaluativeQuestion.find(params[:id])
    @category = @evaluative_question.category
  end

  def update
    @evaluative_question = EvaluativeQuestion.find(params[:id])
    if @evaluative_question.update_attributes(evaluative_question_params)# && category != 'complete'
      redirect_to framework_path(@evaluative_question.framework)
    else
      @category = @evaluative_question.category
      @date_errors = []
      if @evaluative_question.errors["performance_indicators.collection_dates"].any?
        @date_errors = @evaluative_question.errors["performance_indicators.collection_dates"]
      end
      if @evaluative_question.performance_indicators.blank?
        performance_indicator = @evaluative_question.performance_indicators.build
        performance_indicator.collection_dates.build
      else
        @evaluative_question.performance_indicators.each do |indicator|
          if indicator.collection_dates.blank?
            indicator.collection_dates.build
          end
        end
      end
      @date_errors = []
      if @evaluative_question.errors["performance_indicators.collection_dates"].any?
        @date_errors = @evaluative_question.errors["performance_indicators.collection_dates"]
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
      performance_indicators_attributes:
      [
        :id,
        :description,
        :data_source,
        :_destroy,
        collection_dates_attributes:
        [
          :id,
          :date,
          :_destroy
        ]
      ]
    )
  end
end