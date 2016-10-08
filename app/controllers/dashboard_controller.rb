class DashboardController < ApplicationController
  def home
    @performance_indicators = PerformanceIndicator.all
  end
end
