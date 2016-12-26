class CreatePerformanceIndicators < ActiveRecord::Migration[5.0]
  def change
    create_table :performance_indicators do |t|
      t.text :description
      t.string :data_source

      t.timestamps
    end
  end
end
