class SubQuestion < ApplicationRecord
  belongs_to :evaluative_question, inverse_of: :sub_questions
  has_many :performance_indicators, inverse_of: :sub_question

  accepts_nested_attributes_for :performance_indicators, reject_if: :all_blank, allow_destroy: true

  validates :description, presence: true
  validates :monitoring_information, presence: true
end
