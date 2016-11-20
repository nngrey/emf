class SurveyTemplatesController < ApplicationController

  def new
    @framework = Framework.find(params[:framework_id])
    @evaluative_question = @framework.evaluative_questions.find_by(category: 'effectiveness')
    @survey_template = @framework.survey_templates.new
    @data_question = @survey_template.data_questions.build
    @option = @data_question.options.build
  end

  def create
    @framework = Framework.find(params[:framework_id])
    @survey_template = @framework.survey_templates.new(survey_template_params)
    if @survey_template.save
      redirect_to framework_survey_template_path(@framework, @survey_template)
    else
      render "new"
    end
  end

  def show
    @survey_template = SurveyTemplate.find(params[:id])
  end

  def index
    @survey_templates = SurveyTemplate.all
  end

  def results_index
    @survey_templates = SurveyTemplate.all
  end

  def results
    @survey_template = SurveyTemplate.find(params[:id])
  end

  private

  def survey_template_params
    params.require(:survey_template).permit(
      :name,
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
          :_destroy,
        ]
      ]
    )
  end

end