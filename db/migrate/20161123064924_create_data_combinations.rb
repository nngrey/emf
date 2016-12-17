class CreateDataCombinations < ActiveRecord::Migration[5.0]
  def change
    create_table :data_combinations do |t|
      t.string :title
      t.text :description
      t.references :survey_template, foreign_key: true
      t.string :criterion_1
      t.string :criterion_2
      t.string :data_question_1_id
      t.string :data_question_2_id
      t.string :display_value
      t.string :data_label_1
      t.string :data_label_2
      t.timestamps
    end
  end
end
