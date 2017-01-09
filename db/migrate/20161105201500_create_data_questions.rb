class CreateDataQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :data_questions do |t|
      t.text :description
      t.string :type
      t.boolean :multiple_answers, :default => false
      t.integer :position
      t.references :performance_indicator, foreign_key: true

      t.timestamps
    end
  end
end
