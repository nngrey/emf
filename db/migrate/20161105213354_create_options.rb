class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.text :description
      t.references :data_question, foreign_key: true

      t.timestamps
    end
  end
end
