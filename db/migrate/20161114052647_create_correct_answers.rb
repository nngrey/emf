class CreateCorrectAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :correct_answers do |t|
      t.text :input_value
      t.references :survey_question, foreign_key: true
      t.references :data_question, foreign_key: true
      t.timestamps
    end
  end
end
