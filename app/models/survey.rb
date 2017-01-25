class Survey < ApplicationRecord
  has_many :survey_responses, inverse_of: :survey
  has_many :data_questions, inverse_of: :survey

  belongs_to :survey_template, inverse_of: :surveys

  # accepts_nested_attributes_for :survey_questions, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :data_questions, reject_if: :all_blank, allow_destroy: true

end
