class SubQuestion < ApplicationRecord
  belongs_to :evaluative_question, inverse_of: :sub_questions
end
