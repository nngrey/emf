class AddChartTypeToPerformanceIndicators < ActiveRecord::Migration[5.0]
  def change
    add_column :performance_indicators, :chart_type, :string
  end
end
