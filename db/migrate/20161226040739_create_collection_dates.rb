class CreateCollectionDates < ActiveRecord::Migration[5.0]
  def change
    create_table :collection_dates do |t|
      t.string :date
      t.references :performance_indicator, foreign_key: true

      t.timestamps
    end
  end
end
