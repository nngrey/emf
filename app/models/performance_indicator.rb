class PerformanceIndicator < ApplicationRecord
  belongs_to :sub_question

  validates :description, presence: true
  validates :definition, presence: true
  validates :numerator_label, presence: true
  validates :denominator_label, presence: true
  validates :numerator, numericality: true, on: :update, allow_blank: true
  validates :denominator, numericality: true, on: :update, allow_blank: true
  validate :unique_labels

  def unique_labels
    if numerator_label == denominator_label
      errors.add(:denominator_label, "can't match primary label")
    end
  end
end
