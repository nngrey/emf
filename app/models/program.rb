class Program < ApplicationRecord
  belongs_to :organization
  has_one :framework
  has_one :logic_model
  has_many :budgets, inverse_of: :program

  accepts_nested_attributes_for :budgets, reject_if: :all_blank, allow_destroy: true

  validates :name, uniqueness: true

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

####################################################
#Almost there

    budget.budget_entries.each do |entry|
      month = Date.parse(entry.date).month
      year = Date.parse(entry.date).year
      date = "#{year}-#{month}-01".to_date
      average_series[:data][date] = cumulative_budget
      cumulative_budget += average_amount
    end
    date = average_series[:data].to_a.last[0] + 1.month
    average_series[:data][date] = cumulative_budget

#########################################################
    # month = Date.parse(entry.date).month
    # year = Date.parse(entry.date).year
    # date = "#{year}-#{month}-01".to_date
    # average_series[:data][date] = entry.amount
    # entry = budget.budget_entries.last
    # month = Date.parse(self.end_date).month + 1
    # last_month = correct_month(month)
    # year = Date.parse(self.end_date).year
    # last_year = last_month == '01' ? year + 1 : year
    # date = "#{last_year}-#{last_month}-01".to_date
    # average_series[:data][date] = total
    budget_array << average_series

    actual_series = {}
    actual_series[:name] = 'actual'
    actual_series[:data] = {}
    # actual_series[:data][self.start_date] = 0

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

    # start_date = Date.parse(self.start_date)
    # end_date = Date.parse(self.end_date)
    # start_days = 30.5 - start_date.day
    # end_days = end_date.day
    # full_months = (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month) - 2
    # years = full_months / 12
    # total_days = ((full_months * 30.5) + start_days + end_days).round
    # daily_average = total / total_days
    # monthly_average = (daily_average * 30.5).round
    # first_full_month = correct_month(start_date.month + 1)
    # year_index = 0
    # month_index = 1
    # remaining_budget = total - (start_days * daily_average)
    # (full_months + 1).times do
    #   month = correct_month(first_full_month + month_index)
    #   year_index = month == '01' ? year_index + 1 : year_index
    #   date = "01/#{correct_month(first_full_month + month_index)}/#{Date.parse(self.start_date).year + year_index}"
    #   series[:data][date] = remaining_budget
    #   month_index +=1
    #   remaining_budget = remaining_budget - monthly_average
    # end

    # series[:data][budget.budget_entries.last.date] = 0
    # budget.budget_entries.drop(1).each do |entry|
    #   series[:data][entry.date] = total - entry.amount
    #   total -= entry.amount
    # end

  def correct_month(month)
    month > 12 ? 01 : month
  end
end
