class Outcome < ApplicationRecord
  belongs_to :logic_model, inverse_of: :outcomes

  validates :description, presence: true
end
