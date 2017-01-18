require 'rails_helper'

RSpec.describe Program, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:program)).to be_valid
  end

  it 'can be simply created' do
    program = FactoryGirl.build(:program)
    expect{ program.save }.to change{ Program.count }.by(1)
  end

  it { should belong_to(:organization) }
  it { should have_one(:framework) }
  it { should have_one(:logic_model) }
  it { should have_many(:budgets) }

  it { should accept_nested_attributes_for(:budgets) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  it "is not valid if the end_date is before the start_date" do
    program = FactoryGirl.build(:program, start_date: Date.today, end_date: Date.today - 1)
  end
end

##TODO tests for remaining methods in model