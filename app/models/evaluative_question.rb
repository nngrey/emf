class EvaluativeQuestion < ApplicationRecord
  has_many :sub_questions, inverse_of: :evaluative_question

  accepts_nested_attributes_for :sub_questions, allow_destroy: true
end
