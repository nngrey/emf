class SurveyTemplatesController < ApplicationController

  def new
    @framework = Framework.find(params[:framework_id])
    @survey_template = @framework.survey_templates.new
  end

  def create
    @framework = Framework.find(params[:framework_id])
    @survey_template = @framework.survey_templates.new(survey_template_params)
    if @survey_template.save && (params['commit'] == "Continue")
      redirect_to new_survey_template_data_question_path(@survey_template)
    elsif @survey_template.save && (params['commit'] == "Done")
      redirect_to framework_survey_template_path(@framework, @survey_template)
    else
      render "new"
    end
  end

  def show
    @survey_template = SurveyTemplate.find(params[:id])
    @data_questions = @survey_template.data_questions.order('position')
  end

  def index
    @framework = Framework.find(params[:framework_id])
    @survey_templates = @framework.survey_templates
  end

  def results_index
    @survey_templates = SurveyTemplate.all
  end

  def results
    @survey_template = SurveyTemplate.find(params[:id])
    @analyses = @survey_template.data_combinations.map{|dc| dc.analyses}.flatten
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