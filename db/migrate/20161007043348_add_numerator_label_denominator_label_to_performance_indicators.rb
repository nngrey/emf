class AddNumeratorLabelDenominatorLabelToPerformanceIndicators < ActiveRecord::Migration[5.0]
  def change
    add_column :performance_indicators, :numerator_label, :string
    add_column :performance_indicators, :denominator_label, :string
  end
end
