class SurveyQuestion < ApplicationRecord
  has_many :survey_responses, inverse_of: :survey_question
  belongs_to :survey, inverse_of: :survey_questions
  belongs_to :data_question, inverse_of: :survey_questions
end
