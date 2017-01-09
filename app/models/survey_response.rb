class SurveyResponse < ApplicationRecord
  belongs_to :survey_question, inverse_of: :survey_responses
  belongs_to :data_question, inverse_of: :survey_responses

  def self.response_total(data_question_id, input_value)
    self.where(data_question_id: data_question_id, input_value: input_value).count
  end

  def self.multiple_response_total(data_question_id, input_value)
    questions = self.where(data_question_id: data_question_id)
    count = 0
    questions.each do | question |
      if question.input_value.include? input_value
        count += 1
      end
    end
    count
  end
end
