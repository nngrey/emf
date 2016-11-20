class Framework < ApplicationRecord
  has_many :evaluative_questions, inverse_of: :framework
  has_many :survey_templates, inverse_of: :framework
  belongs_to :organization, inverse_of: :frameworks

  accepts_nested_attributes_for :evaluative_questions, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :survey_templates, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
end
