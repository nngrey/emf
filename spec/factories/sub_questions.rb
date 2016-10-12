  FactoryGirl.define do
  factory :sub_question do
    description { FFaker::Lorem.sentence }
    monitoring_information { FFaker::Lorem.sentence }
    after :build do |sub_question|
      create_list :performance_indicator, 1, sub_question: sub_question   # has_many
    end
  end
end