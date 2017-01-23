require 'rails_helper'

RSpec.describe Framework, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:framework)).to be_valid
  end

  it "is valid with all required attributes" do
    expect(FactoryGirl.build(:framework)).to be_valid
  end

  it { should have_many(:evaluative_questions) }
  it { should have_many(:survey_templates) }
  it { should belong_to(:program) }

  it { should accept_nested_attributes_for(:evaluative_questions) }
  it { should accept_nested_attributes_for(:survey_templates) }
end