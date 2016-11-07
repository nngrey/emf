class SurveyTemplatesController < ApplicationController

  def new
    @survey_template = SurveyTemplate.new
    @data_question = @survey_template.data_questions.build
    @option = @data_question.options.build
  end

  def create
    @survey_template = SurveyTemplate.new(survey_template_params)
    if @survey_template.save
      redirect_to survey_template_path(@survey_template)
    else
      render "new"
    end
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