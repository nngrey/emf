require 'rails_helper'

RSpec.describe SurveyTemplate, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:survey_template)).to be_valid
  end

  it 'can be simply created' do
   survey_template = FactoryGirl.build(:survey_template)
   expect{ survey_template.save }.to change{ SurveyTemplate.count }.by(1)
  end

  it { should have_many(:data_questions) }
  it { should have_many(:surveys) }
  it { should have_many(:data_combinations) }

  it { should belong_to(:framework) }

  it { should accept_nested_attributes_for(:data_questions) }
  it { should accept_nested_attributes_for(:surveys) }
  it { should accept_nested_attributes_for(:data_combinations) }
end
