class EvaluativeQuestion < ApplicationRecord
  has_many :performance_indicators, inverse_of: :evaluative_question
  belongs_to :framework, inverse_of: :evaluative_questions

  accepts_nested_attributes_for :performance_indicators, reject_if: :all_blank, allow_destroy: true

  validates :category, presence: true
  validates :description, presence: true
  validates_associated :performance_indicators
  validates_presence_of :performance_indicators

  scope :appropriateness, -> { where(category: 'appropriateness') }
  scope :efficiency, -> { where(category: 'efficiency') }
  scope :effectiveness, -> { where(category: 'effectiveness') }
  scope :impact, -> { where(category: 'impact') }
  scope :sustainability, ->{ where(category: 'sustainability') }

  def has_performance_indicators?
    self.sub_questions.map{ |q| q.performance_indicators }.flatten.any?
  end
end
