class CreateEvaluativeQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluative_questions do |t|
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end
