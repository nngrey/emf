class CreateLogicModels < ActiveRecord::Migration[5.0]
  def change
    create_table :logic_models do |t|
      t.references :program, foreign_key: true

      t.timestamps
    end
  end
end
