class PerformanceIndicator < ApplicationRecord
  belongs_to :sub_question

  validates :description, presence: true
  validates :definition, presence: true
  validates :numerator_label, presence: true
  validates :denominator_label, presence: true
end
