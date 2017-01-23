require 'rails_helper'

RSpec.describe EvaluativeQuestion, type: :model do
  let(:collection_date){ FactoryGirl.create(:collection_date) }
  let(:performance_indicator){ FactoryGirl.create(:performance_indicator, collection_dates: [collection_date])}

  it "has a valid factory" do
    expect(FactoryGirl.create(:evaluative_question, performance_indicators: [performance_indicator])).to be_valid
  end

  it 'can be simply created' do
   evaluative_question = FactoryGirl.build(:evaluative_question, performance_indicators: [performance_indicator])
   expect{ evaluative_question.save }.to change{ EvaluativeQuestion.count }.by(1)
  end

  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:performance_indicators)}

  it { should have_many(:performance_indicators) }
  it { should belong_to(:framework) }

  it { should accept_nested_attributes_for(:performance_indicators) }
end