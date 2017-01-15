class LogicModel < ApplicationRecord
  belongs_to :program
  has_many :logic_model_inputs, inverse_of: :logic_model
  has_many :activities, inverse_of: :logic_model
  has_many :outputs, inverse_of: :logic_model
  has_many :outcomes, inverse_of: :logic_model
  has_many :impacts, inverse_of: :logic_model

  accepts_nested_attributes_for :logic_model_inputs, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :activities, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :outputs, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :outcomes, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :impacts, reject_if: :all_blank, allow_destroy: true

  validates_associated :logic_model_inputs
  validates_associated :activities
  validates_associated :outputs
  validates_associated :outcomes
  validates_associated :impacts

  def timeline_data
    timeline_array = []
    self.activities.each do |activity|
      activity_array = [activity.name, activity.start_date, activity.end_date]
      timeline_array << activity_array
    end
    timeline_array
  end
end
