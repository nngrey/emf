class CreateSurveyResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :survey_responses do |t|
      t.text :input_value
      t.references :survey, foreign_key: true
      t.references :data_question, foreign_key: true
      t.timestamps
    end
  end
end
