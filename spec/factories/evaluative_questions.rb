FactoryGirl.define do
  factory :evaluative_question do
    category ['effectiveness', 'efficiency'].sample
    description { FFaker::Lorem.sentence }
    association :framework, factory: :framework, strategy: :build
  end
end
