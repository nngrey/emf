class SurveyTemplate < ApplicationRecord
  has_many :data_questions, inverse_of: :survey_template
  has_many :surveys, inverse_of: :survey_template
  belongs_to :framework, inverse_of: :survey_templates

  accepts_nested_attributes_for :data_questions, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :surveys, reject_if: :all_blank, allow_destroy: true
end
