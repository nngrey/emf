class DataCombination < ApplicationRecord
  attr_accessor :bar, :baz

  has_many :analyses, inverse_of: :data_combination

  belongs_to :survey_template, inverse_of: :data_combinations

  accepts_nested_attributes_for :analyses, reject_if: :all_blank, allow_destroy: true
end
