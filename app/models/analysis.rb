class Analysis < ApplicationRecord
  belongs_to :data_combination, inverse_of: :analyses

  scope :display, -> { where.not(display_value: 'Do not display') }

  def build_data_hash
    combination = self.data_combination
    survey_template = data_combination.survey_template
    data_hash = {}
    combination_count = 0
    survey_template.surveys.each do |survey|
      survey_question_1 = survey.survey_questions.find_by(data_question_id: combination.data_question_1_id)
      survey_question_2 = survey.survey_questions.find_by(data_question_id: combination.data_question_2_id)
      response_1 = survey_question_1.survey_responses.first.input_value
      response_2 = survey_question_2.survey_responses.first.input_value
      option_1 = Option.find(combination.criterion_1).description
      option_2 = Option.find(combination.criterion_2).description
      if (response_1 == option_1) && (response_2 == option_2)
        combination_count += 1
        data_hash[combination.data_label_1] = combination_count
      end
    end
    data_hash[combination.data_label_2] = survey_template.surveys.count - combination_count
    data_hash
  end
end
