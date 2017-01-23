require 'rails_helper'

RSpec.describe Organization, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:organization)).to be_valid
  end

  it 'can be simply created' do
    organization = FactoryGirl.build(:organization)
    expect{ organization.save }.to change{ Organization.count }.by(1)
  end

  it { should validate_presence_of(:name) }

  it { should have_many(:programs) }

  it { should accept_nested_attributes_for(:programs) }
end