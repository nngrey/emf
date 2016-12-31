class DataCombinationsController < ApplicationController

  def new
    @survey_template = SurveyTemplate.find(params[:survey_template_id])
    @data_combination = @survey_template.data_combinations.new
  end

  def create
    survey_template = SurveyTemplate.find(params[:survey_template_id])
    if @data_combination = survey_template.data_combinations.create(data_combination_params)
      @data_combination.analyses.create(title: @data_combination.title, description: @data_combination.description)
      redirect_to results_survey_template_path(survey_template.id)
    else
      render 'new'
    end
  end

  # TODO add edit / update

  private
  def data_combination_params
    params.require(:data_combination).permit(
      :id,
      :title,
      :category,
      :description,
      :criterion_1,
      :criterion_2,
      :data_question_1_id,
      :data_question_2_id,
      :data_label_1,
      :data_label_2
    )
  end
end