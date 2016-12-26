class Framework < ApplicationRecord
  has_many :evaluative_questions, inverse_of: :framework
  has_many :survey_templates, inverse_of: :framework
  belongs_to :program

  accepts_nested_attributes_for :evaluative_questions, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :survey_templates, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true

  # def create_data_hash(category)
  #   if self.survey_templates.any?
  #   ##TODO what if we have more than one survey template???
  #     survey_template = self.survey_template.first
  #     if survey_template.has_responses?
  #       survey_template.data_questions.each do |question|
  #         - data_hash = {}
  #         - question.options.each do |option|
  #           - if ['Yes / No', 'True / False', 'Multiple choice'].include? question.question_type
  #             - survey_response = SurveyResponse.response_total(question.id, option.description)
  #             - data_hash[option.description] = survey_response
  # end
end
