class AddSurveyIdToDataQuestion < ActiveRecord::Migration[5.0]
  def change
    add_reference :data_questions, :survey, foreign_key: true
  end
end
