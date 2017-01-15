class Program < ApplicationRecord
  belongs_to :organization
  has_one :framework
  has_one :logic_model
  has_many :budgets, inverse_of: :program

  accepts_nested_attributes_for :budgets, reject_if: :all_blank, allow_destroy: true

  validates :name, uniqueness: true
  validates :name, presence: true
  validate :end_date_is_after_start_date

  #TODO Should we add validations for budget, start date, end date?

  def question_hints(category)
    if category == 'appropriateness'
      hint = "You should include evaluative questions that measure the
        relevance or appropriateness of your program to the target population,
        such as 'Does the target population agree that the problem should be addressed?' and
        'Does the target population agree with the proposed solution?'"
    end
    hint
  end

  def indicator_hints(category)
    if category == 'appropriateness'
      hint = "Performance indicators describe how you will answer an evaluative question,
        such as 'The percentage of the target population who agree that the problem should be addressed' and
        'The percentage of the target population who agree with the proposed solution'. You should have one
        or more performance indicators for each evaluative question."
    end
    hint
  end

  def correct_category(current_category, step)
    correct_category = 'appropriateness'
    if step == 'current'
      correct_category = current_category
    elsif step == 'next'
      if current_category == 'appropriateness'
        correct_category = 'efficiency'
      end
      if current_category == 'efficiency'
        correct_category = 'effectiveness'
      end
      if current_category == 'effectiveness'
        correct_category = 'impact'
      end
      if current_category == 'impact'
        correct_category = 'sustainability'
      end
      if current_category == 'sustainability'
        correct_category = 'complete'
      end
    end
    correct_category
  end

  def budget_data
    budget_array = []
    budget = self.budgets.find_by(name: 'actual')
    if budget.present? && budget.budget_entries.any?
      entry = budget.budget_entries.first
      total = budget.total
      average_series = {}
      average_series[:name] = 'average'
      average_series[:data] = {}
      cumulative_budget = entry.amount
      start_date = Date.parse(self.start_date)
      end_date = Date.parse(self.end_date)
      months = (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month) - 1
      average_amount = (total - entry.amount)/months
      first_month = Date.parse(entry.date).month
      first_year = Date.parse(entry.date).year
      months.times do
        date = "#{first_year}-#{first_month}-01".to_date
        average_series[:data][date] = cumulative_budget
        cumulative_budget += average_amount
        first_month = first_month + 1
      end
      date = average_series[:data].to_a.last[0] + 1.month
      average_series[:data][date] = cumulative_budget
      budget_array << average_series

      actual_series = {}
      actual_series[:name] = 'actual'
      actual_series[:data] = {}

      year_index = 0
      month_index = 1
      cumulative_budget = 0
      budget.budget_entries.each do |entry|
        cumulative_budget = cumulative_budget + entry.amount
        month = Date.parse(entry.date).month
        year = Date.parse(entry.date).year
        date = "#{year}-#{month}-01".to_date
        actual_series[:data][date] = cumulative_budget
      end
      budget_array << actual_series
      budget_array
    end
  end

  def correct_month(month)
    month > 12 ? 01 : month
  end
end

private

def end_date_is_after_start_date
  return if end_date.blank? || start_date.blank?

  if end_date < start_date
    errors.add(:end_date, "cannot be before the start date")
  end
end
