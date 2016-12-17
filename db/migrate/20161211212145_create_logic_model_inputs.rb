class CreateLogicModelInputs < ActiveRecord::Migration[5.0]
  def change
    create_table :logic_model_inputs do |t|
      t.text :description
      t.integer :budget
      t.references :logic_model, foreign_key: true

      t.timestamps
    end
  end
end
