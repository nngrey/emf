require 'rails_helper'

RSpec.describe LogicModel, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:logic_model)).to be_valid
  end
end