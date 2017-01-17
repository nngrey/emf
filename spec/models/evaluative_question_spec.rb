# require 'rails_helper'

# RSpec.describe EvaluativeQuestion, type: :model do

#   it "has a valid factory" do
#     expect(FactoryGirl.create(:evaluative_question)).to be_valid
#   end

#   it "is valid with all required attributes" do
#     expect(FactoryGirl.build(:evaluative_question)).to be_valid
#   end

#   it "is invalid without a category" do
#     expect(FactoryGirl.build(:evaluative_question, category: nil)).to_not be_valid
#   end

#   it "is invalid without a description" do
#     expect(FactoryGirl.build(:evaluative_question, description: nil)).to_not be_valid
#   end

#   it "is invalid without a framework" do
#     expect(FactoryGirl.build(:evaluative_question, framework: nil)).to_not be_valid
#   end

#   let(:evaluative_question){ FactoryGirl.create(:evaluative_question) }

#   before do
#     evaluative_question.sub_questions = []
#   end

#   it "is invalid without sub_questions" do
#     expect(evaluative_question).to_not be_valid
#   end
# end
