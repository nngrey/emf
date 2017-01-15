class Activity < ApplicationRecord
  belongs_to :logic_model, inverse_of: :activities

  validates :name, presence: true
  validates :description, presence: true
  validate :end_date_is_after_start_date
  #TODO Validate presence of budget and dates

  private

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "cannot be before the start date")
    end
  end
end
