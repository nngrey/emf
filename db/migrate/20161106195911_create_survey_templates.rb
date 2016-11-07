class CreateSurveyTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :survey_templates do |t|
      t.string :name
      t.references :evaluative_question, foreign_key: true
      t.timestamps
    end
  end
end