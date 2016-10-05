class CreateSubQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :sub_questions do |t|
      t.text :description
      t.text :monitoring_information
      t.references :evaluative_question, foreign_key: true

      t.timestamps
    end
  end
end
