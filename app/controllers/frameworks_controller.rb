class FrameworksController < ApplicationController

  def index
    @frameworks = Framework.all
  end

  def show
    @view_as = params[:view_as] || 'list'
    @framework = Framework.find(params[:id])
    @evaluative_questions = @framework.evaluative_questions
  end

  def new
    @framework = Framework.new
  end

  def create
    @organization = Organization.first
    @framework = @organization.frameworks.new(framework_params)
    if @framework.save
      redirect_to new_evaluative_question_path(framework_id: @framework.id)
    else
      render "new"
    end
  end

  def edit
    @framework = Framework.find(params[:id])
  end

  def update
    @framework = Framework.find(params[:id])
    if @framework.update_attributes(framework_params)
      redirect_to frameworks_path
    else
      render 'edit'
    end
  end

  def dashboard
    @framework = Framework.find(params[:id])
    # TODO how do we compile data from multiple survey templates???
    @survey_template = @framework.survey_templates.first if @framework.survey_templates.any?
  end

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