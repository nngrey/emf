FactoryGirl.define do
  factory :framework do
    name { FFaker::Lorem.phrase }
  end
end