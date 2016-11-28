class CreateAnalyses < ActiveRecord::Migration[5.0]
  def change
    create_table :analyses do |t|
      t.string :display_value, :default => "Do not display"
      t.string :title
      t.text :description
      t.references :data_combination, foreign_key: true

      t.timestamps
    end
  end
end
