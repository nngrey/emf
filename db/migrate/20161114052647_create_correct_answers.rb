class CreateCorrectAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :correct_answers do |t|
      t.references :survey_question, foreign_key: true
      t.timestamps
    end
  end
end
