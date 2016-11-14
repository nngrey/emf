class DataQuestion < ApplicationRecord
  attr_accessor :foo

  belongs_to :performance_indicator, inverse_of: :data_questions
  belongs_to :survey_template, inverse_of: :data_questions
  has_many :options, inverse_of: :data_question
  has_many :correct_answers, inverse_of: :data_question

  accepts_nested_attributes_for :options, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :correct_answers, reject_if: :all_blank, allow_destroy: true
end
