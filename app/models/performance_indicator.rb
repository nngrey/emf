class PerformanceIndicator < ApplicationRecord
  has_many :data_questions, inverse_of: :performance_indicator
  has_many :collection_dates, inverse_of: :performance_indicator
  belongs_to :evaluative_question, inverse_of: :performance_indicators

  accepts_nested_attributes_for :data_questions, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :collection_dates, reject_if: :all_blank, allow_destroy: true

  validates :description, presence: true
  validates :data_source, presence: true
  validates_associated :collection_dates

  def self.categories
    ['appropriateness', 'effectiveness', 'efficiency', 'impact', 'sustainability']
  end

  def unique_labels
    if numerator_label == denominator_label
      errors.add(:denominator_label, "can't match primary label")
    end
  end
end
