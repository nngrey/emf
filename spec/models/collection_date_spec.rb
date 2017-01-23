require 'rails_helper'

RSpec.describe CollectionDate, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:collection_date)).to be_valid
  end

  it 'can be simply created' do
    collection_date = FactoryGirl.build(:collection_date)
    expect{ collection_date.save }.to change{ CollectionDate.count }.by(1)
  end

  it { should validate_presence_of(:date) }
  it { should belong_to(:performance_indicator) }
end