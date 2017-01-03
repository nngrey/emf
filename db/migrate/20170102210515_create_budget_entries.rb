class CreateBudgetEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :budget_entries do |t|
      t.integer :amount
      t.string :date
      t.references :budget, foreign_key: true

      t.timestamps
    end
  end
end
