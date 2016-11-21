class SurveyTemplate < ApplicationRecord
  has_many :data_questions, inverse_of: :survey_template
  has_many :surveys, inverse_of: :survey_template
  belongs_to :framework, inverse_of: :survey_templates

  accepts_nested_attributes_for :data_questions, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :surveys, reject_if: :all_blank, allow_destroy: true

  def has_responses?
    self.surveys.map{|s| s.survey_questions}.flatten.map{|q| q.survey_responses}.flatten.any?
  end

  def build_options
    self.data_questions.each do |question|
      if question.question_type == 'Yes / No'
        question.options.create(description: 'Yes')
        question.options.create(description: 'No')
      elsif question.question_type == 'True / False'
        question.options.create(description: 'True')
        question.options.create(description: 'False')
      end
    end
  end
end
