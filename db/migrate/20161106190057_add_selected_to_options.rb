class AddSelectedToOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :options, :selected, :boolean
  end
end
