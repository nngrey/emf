FactoryGirl.define do
  factory :performance_indicator do
    description { FFaker::Lorem.sentence }
    definition { FFaker::Lorem.sentence }
    numerator_label { FFaker::Lorem.phrase }
    denominator_label { FFaker::Lorem.phrase }
    numerator 10
    denominator 11
  end
end
