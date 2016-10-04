class DashboardController < ApplicationController
  def home
    @items = []
    6.times do
      @items << OpenStruct.new(num: [3, 6, 9, 12, 16, 4].sample)
    end
    @items
  end
end
