class PerformanceIndicator < ApplicationRecord
  has_many :data_questions, inverse_of: :performance_indicator
  has_many :collection_dates, inverse_of: :performance_indicator
  belongs_to :evaluative_question, inverse_of: :performance_indicators

  accepts_nested_attributes_for :data_questions, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :collection_dates, reject_if: :all_blank, allow_destroy: true

  validates :description, presence: true
  # validates :definition, presence: true
  # validate :unique_labels

  # scope :appropriateness, -> { joins(sub_question: :evaluative_question).where(evaluative_questions: { category: 'appropriateness' }).order(:created_at) }
  # scope :effectiveness, -> { joins(sub_question: :evaluative_question).where(evaluative_questions: { category: 'effectiveness' }).order(:created_at) }
  # scope :efficiency, -> { joins(sub_question: :evaluative_question).where(evaluative_questions: { category: 'efficiency' }).order(:created_at) }
  # scope :impact, -> { joins(sub_question: :evaluative_question).where(evaluative_questions: { category: 'impact' }).order(:created_at) }
  # scope :sustainability, -> { joins(sub_question: :evaluative_question).where(evaluative_questions: { category: 'sustainability' }).order(:created_at) }

  def self.categories
    ['appropriateness', 'effectiveness', 'efficiency', 'impact', 'sustainability']
  end

  def unique_labels
    if numerator_label == denominator_label
      errors.add(:denominator_label, "can't match primary label")
    end
  end
end
