class Analysis < ApplicationRecord
  belongs_to :data_combination, inverse_of: :analyses

  scope :appropriateness, -> { where(category: 'appropriateness') }
  scope :efficiency, -> { where(category: 'efficiency') }
  scope :effectiveness, -> { where(category: 'effectiveness') }
  scope :impact, -> { where(category: 'impact') }
  scope :sustainability, ->{ where(category: 'sustainability') }

  def build_data_hash
    combination = self.data_combination
    survey_template = data_combination.survey_template
    data_hash = {}
    combination_count = 0
    survey_template.surveys.each do |survey|
      data_question_1 = DataQuestion.find(combination.data_question_1_id)
      data_question_2 = DataQuestion.find(combination.data_question_2_id)
      response_1 = data_question_1.survey_responses.find_by(survey_id: survey.id).input_value
      response_2 = data_question_2.survey_responses.find_by(survey_id: survey.id).input_value
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
