class EvaluativeQuestion < ApplicationRecord
  # has_many :sub_questions, inverse_of: :evaluative_question
  has_many :performance_indicators, inverse_of: :evaluative_question
  # has_many :survey_templates, inverse_of: :evaluative_question
  belongs_to :framework, inverse_of: :evaluative_questions

  # accepts_nested_attributes_for :sub_questions, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :performance_indicators, reject_if: :all_blank, allow_destroy: true
  # accepts_nested_attributes_for :survey_templates, reject_if: :all_blank, allow_destroy: true

  validates :category, presence: true
  validates :description, presence: true
  # validates_presence_of :sub_questions
  validates_associated :framework #:sub_questions
  validates_presence_of :framework

  def has_performance_indicators?
    self.sub_questions.map{ |q| q.performance_indicators }.flatten.any?
  end
end
