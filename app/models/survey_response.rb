class SurveyResponse < ApplicationRecord
  belongs_to :survey_question, inverse_of: :survey_responses
  belongs_to :data_question, inverse_of: :survey_responses

  def self.response_total(data_question_id, input_value)
    self.where(data_question_id: data_question_id, input_value: input_value).count
  end
end
