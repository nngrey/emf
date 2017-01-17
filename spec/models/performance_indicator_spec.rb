# require 'rails_helper'

# RSpec.describe PerformanceIndicator, type: :model do

#   it "has a valid factory" do
#     expect(FactoryGirl.create(:performance_indicator)).to be_valid
#   end

#   it "is valid with all required attributes" do
#     expect(FactoryGirl.build(:performance_indicator)).to be_valid
#   end

#   it "is invalid without a description" do
#     expect(FactoryGirl.build(:performance_indicator, description: nil)).to_not be_valid
#   end

#   it "is invalid without a definition" do
#     expect(FactoryGirl.build(:performance_indicator, definition: nil)).to_not be_valid
#   end

#   it "is invalid without a numerator_label" do
#     expect(FactoryGirl.build(:performance_indicator, numerator_label: nil)).to_not be_valid
#   end

#   it "is invalid without a denominator_label" do
#     expect(FactoryGirl.build(:performance_indicator, denominator_label: nil)).to_not be_valid
#   end

#   it "requires the numerator_label and denominator_label to be different" do
#     expect(FactoryGirl.build(:performance_indicator, numerator_label: 'abc', denominator_label: 'xyz')).to be_valid
#   end

#   it "does not allow the numerator_label and denominator_label to be the same" do
#     expect(FactoryGirl.build(:performance_indicator, numerator_label: 'abc', denominator_label: 'abc')).to_not be_valid
#   end
# end
