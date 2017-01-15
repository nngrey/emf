class LogicModelInput < ApplicationRecord
  belongs_to :logic_model, inverse_of: :logic_model_inputs

  validates :description, presence: true
end
