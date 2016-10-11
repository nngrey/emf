class FrameworksController < ApplicationController

  def new
    @framework = Framework.new
  end

  def create
    @framework = Framework.new(framework_params)
    if @framework.save
      redirect_to new_evaluative_question_path
    else
      render "new"
    end
  end

  def edit
    @framework = Framework.find(params[:id])
  end

  def update
    @framework = Framework.find(params[:id])
    binding.pry
    if @framework.update_attributes(framework_params)
      redirect_to framework_path(@framework)
    else
      render 'edit'
    end
  end

  def index
    @frameworks = Framework.all
  end

  def show
    @view_as = params[:view_as] || 'list'
    @framework = Framework.find(params[:id])
    @evaluative_questions = @framework.evaluative_questions
  end

  # private
  # def framework_params
  #   params.require(:framework).permit(:id, :name)
  # end

  private
  def framework_params
    params.require(:framework).permit(
      :id,
      :name,
      evaluative_questions_attributes:
      [
        :id,
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
            :id,
            :description,
            :definition,
            :numerator,
            :denominator,
            :numerator_label,
            :denominator_label,
            :_destroy
          ]
        ]
      ]
    )
  end
end