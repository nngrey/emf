class SurveyQuestion < ApplicationRecord
  has_many :correct_answers, inverse_of: :survey_question
  belongs_to :survey, inverse_of: :survey_questions
  belongs_to :data_question, inverse_of: :survey_questions

  # accepts_nested_attributes_for :correct_answers, reject_if: :all_blank, allow_destroy: true
end
