require 'rails_helper'

RSpec.describe LogicModel, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:logic_model)).to be_valid
  end

  it 'can be simply created' do
    logic_model = FactoryGirl.build(:logic_model)
    expect{ logic_model.save }.to change{ LogicModel.count }.by(1)
  end

  it { should belong_to(:program) }
  it { should have_many(:logic_model_inputs) }
  it { should have_many(:activities) }
  it { should have_many(:outputs) }
  it { should have_many(:outcomes) }
  it { should have_many(:impacts) }

  it { should accept_nested_attributes_for(:logic_model_inputs) }
  it { should accept_nested_attributes_for(:activities) }
  it { should accept_nested_attributes_for(:outputs) }
  it { should accept_nested_attributes_for(:outcomes) }
  it { should accept_nested_attributes_for(:impacts) }
end