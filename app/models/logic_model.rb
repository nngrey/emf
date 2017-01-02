class LogicModel < ApplicationRecord
  belongs_to :program
  has_many :logic_model_inputs
  has_many :activities
  has_many :outputs
  has_many :outcomes
  has_many :impacts

  accepts_nested_attributes_for :logic_model_inputs, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :activities, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :outputs, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :outcomes, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :impacts, reject_if: :all_blank, allow_destroy: true
end
