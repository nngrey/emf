class CorrectAnswer < ApplicationRecord
  belongs_to :survey_question, inverse_of: :correct_answers
end
