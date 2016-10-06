class CreatePerformanceIndicators < ActiveRecord::Migration[5.0]
  def change
    create_table :performance_indicators do |t|
      t.text :description
      t.text :definition
      t.integer :numerator
      t.integer :denominator
      t.references :sub_question, foreign_key: true

      t.timestamps
    end
  end
end
