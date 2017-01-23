require 'rails_helper'

RSpec.describe PerformanceIndicator, type: :model do
  let(:collection_date){ FactoryGirl.create(:collection_date) }

  it "has a valid factory" do
    expect(FactoryGirl.create(:performance_indicator, collection_dates: [collection_date])).to be_valid
  end

  it "is valid with all required attributes" do
    expect(FactoryGirl.build(:performance_indicator, collection_dates: [collection_date])).to be_valid
  end

  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:data_source) }
  it { should validate_presence_of(:collection_dates)}

  it { should have_many(:data_questions) }
  it { should have_many(:collection_dates) }
  it { should belong_to(:evaluative_question) }

  it { should accept_nested_attributes_for(:data_questions) }
  it { should accept_nested_attributes_for(:collection_dates) }
end
