class DataQuestion < ApplicationRecord
  attr_accessor :foo

  belongs_to :performance_indicator, inverse_of: :data_questions
  belongs_to :survey_template, inverse_of: :data_questions
  has_many :options, inverse_of: :data_question
  has_many :survey_questions, inverse_of: :data_question
  has_many :survey_responses, inverse_of: :data_question

  validates :description, presence: true
  validates :question_type, presence: true

  accepts_nested_attributes_for :options, reject_if: :all_blank, allow_destroy: true

  scope :appropriateness, -> { joins(performance_indicator: :evaluative_question).where('evaluative_questions.category' => 'appropriateness') }
  scope :efficiency, -> { joins(performance_indicator: :evaluative_question).where('evaluative_questions.category' => 'efficiency') }
  scope :effectiveness, -> { joins(performance_indicator: :evaluative_question).where('evaluative_questions.category' => 'effectiveness') }
  scope :impact, -> { joins(performance_indicator: :evaluative_question).where('evaluative_questions.category' => 'impact') }
  scope :sustainability, -> { joins(performance_indicator: :evaluative_question).where('evaluative_questions.category' => 'sustainability') }

  def build_options
    if self.question_type == 'Yes / No' && self.options.count <= 2
      self.options.destroy_all
      self.options.create(description: 'Yes')
      self.options.create(description: 'No')
    elsif self.question_type == 'True / False' && self.options.count <= 2
      self.options.destroy_all
      self.options.create(description: 'True')
      self.options.create(description: 'False')
    end
  end
end
