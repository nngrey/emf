class SurveyResponse < ApplicationRecord
  belongs_to :survey_question, inverse_of: :survey_responses
end
