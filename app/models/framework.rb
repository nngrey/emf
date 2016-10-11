class Framework < ApplicationRecord
  has_many :evaluative_questions, inverse_of: :framework

  accepts_nested_attributes_for :evaluative_questions, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
end