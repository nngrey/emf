class SurveyTemplate < ApplicationRecord
  has_many :data_questions, inverse_of: :survey_template
  belongs_to :evaluative_question, inverse_of: :survey_templates

  accepts_nested_attributes_for :data_questions, reject_if: :all_blank, allow_destroy: true
end
