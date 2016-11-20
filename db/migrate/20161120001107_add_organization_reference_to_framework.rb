class AddOrganizationReferenceToFramework < ActiveRecord::Migration[5.0]
  def change
    add_reference :frameworks, :organization, foreign_key: true
  end
end
