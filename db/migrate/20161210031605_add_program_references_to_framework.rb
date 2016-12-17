class AddProgramReferencesToFramework < ActiveRecord::Migration[5.0]
  def change
    add_reference :frameworks, :program, foreign_key: true
  end
end
