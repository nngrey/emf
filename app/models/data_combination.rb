class DataCombination < ApplicationRecord
  attr_accessor :bar, :baz

  has_many :analyses, inverse_of: :data_combination

  belongs_to :survey_template, inverse_of: :data_combinations

  accepts_nested_attributes_for :analyses, reject_if: :all_blank, allow_destroy: true

  scope :appropriateness, -> { where(category: 'appropriateness') }
  scope :efficiency, -> { where(category: 'efficiency') }
  scope :effectiveness, -> { where(category: 'effectiveness') }
  scope :impact, -> { where(category: 'impact') }
  scope :sustainability, ->{ where(category: 'sustainability') }
end
