class CreatePrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :programs do |t|
      t.string :name
      t.string :start_date
      t.string :end_date
      t.references :organization, foreign_key: true

      t.timestamps
    end
  end
end
