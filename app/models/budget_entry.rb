class BudgetEntry < ApplicationRecord
  belongs_to :budget, inverse_of: :budget_entries
end
