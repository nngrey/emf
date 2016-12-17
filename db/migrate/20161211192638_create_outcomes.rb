class CreateOutcomes < ActiveRecord::Migration[5.0]
  def change
    create_table :outcomes do |t|
      t.text :description
      t.references :logic_model, foreign_key: true

      t.timestamps
    end
  end
end
