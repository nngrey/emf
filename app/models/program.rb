class Program < ApplicationRecord
  belongs_to :organization
  has_one :framework
  has_one :logic_model
end
