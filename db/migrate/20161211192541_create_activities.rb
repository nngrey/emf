class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.string :start_date
      t.string :end_date
      t.integer :budget

      t.references :logic_model, foreign_key: true

      t.timestamps
    end
  end
end
