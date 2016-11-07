class CreateDataQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :data_questions do |t|
      t.text :description
      t.string :type
      t.references :performance_indicator, foreign_key: true

      t.timestamps
    end
  end
end
