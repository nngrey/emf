class EvaluativeQuestion < ApplicationRecord
  has_many :sub_questions, inverse_of: :evaluative_question

  accepts_nested_attributes_for :sub_questions, reject_if: :all_blank, allow_destroy: true

  validates :category, presence: true
  validates :description, presence: true
  validates_presence_of :sub_questions
  validates_associated :sub_questions
end
