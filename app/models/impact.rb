class Impact < ApplicationRecord
  belongs_to :logic_model, inverse_of: :impacts

  validates :description, presence: true
end
