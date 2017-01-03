class Budget < ApplicationRecord
  belongs_to :program, inverse_of: :budgets
  has_many :budget_entries, inverse_of: :budget

  accepts_nested_attributes_for :budget_entries, reject_if: :all_blank, allow_destroy: true
end
