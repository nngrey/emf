class Organization < ApplicationRecord
  has_many :frameworks, inverse_of: :organization

  accepts_nested_attributes_for :frameworks, reject_if: :all_blank, allow_destroy: true
end
