FactoryGirl.define do
  factory :evaluative_question do
    category ['effectiveness', 'efficiency'].sample
    description { FFaker::Lorem.sentence }
    association :framework, factory: :framework, strategy: :build
    after :build do |evaluative_question|
      evaluative_question.sub_questions << FactoryGirl.build_list(:sub_question, 1, evaluative_question: nil)
    end
  end
end
