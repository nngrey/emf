FactoryGirl.define do
  factory :performance_indicator do
    description { FFaker::Lorem.sentence }
    data_source { FFaker::Lorem.sentence }
    chart_type ['bar_chart', 'pie_chart'].sample
  end
end
