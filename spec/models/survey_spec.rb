require 'rails_helper'

RSpec.describe Survey, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:survey)).to be_valid
  end

  it 'can be simply created' do
   survey = FactoryGirl.build(:survey)
   expect{ survey.save }.to change{ Survey.count }.by(1)
  end

  it { should have_many(:survey_responses) }
  it { should have_many(:data_questions) }
  it { should belong_to(:survey_template) }

  it { should accept_nested_attributes_for(:data_questions) }
end
