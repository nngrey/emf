class Organization < ApplicationRecord
  has_many :programs, inverse_of: :organization

  accepts_nested_attributes_for :programs, reject_if: :all_blank, allow_destroy: true
end
