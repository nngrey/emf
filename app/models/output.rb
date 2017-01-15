class Output < ApplicationRecord
  belongs_to :logic_model, inverse_of: :outputs

  validates :description, presence: true
end
