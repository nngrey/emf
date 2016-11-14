class SurveyQuestion < ApplicationRecord
  belongs_to :survey, inverse_of: :survey_questions
  belongs_to :data_question
end
