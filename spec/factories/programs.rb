FactoryGirl.define do
  factory :program do
    name { FFaker::Lorem.phrase }
  end
end