class AddSurveyTemplateIdToDataQuestions < ActiveRecord::Migration[5.0]
  def change
    add_reference :data_questions, :survey_template, foreign_key: true
  end
end
