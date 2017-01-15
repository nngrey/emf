# require 'rails_helper'

# RSpec.describe EvaluativeQuestionsController, type: :controller do

#   describe "GET #show" do
#     let(:evaluative_question){ FactoryGirl.create(:evaluative_question) }

#     it "assigns the requested evaluative_question" do
#       get :show, params: { id: evaluative_question.id }
#       assigns(:evaluative_question).should eq(evaluative_question)
#     end

#     it "assigns view_as when there is a param" do
#       get :show, params: { id: evaluative_question.id, view_as: 'table' }
#       assigns(:view_as).should eq('table')
#     end

#     it "assigns view_as as 'list' when there is no param" do
#       get :show, params: { id: evaluative_question.id }
#       assigns(:view_as).should eq('list')
#     end

#     it "renders the #show view" do
#       get :show, params: { id: evaluative_question.id }
#       response.should render_template :show
#     end
#   end

#   describe "GET #new" do
#     let(:framework){ FactoryGirl.create(:framework) }

#     it "assigns the parent framewrok" do
#       get :new, params: { framework_id: framework.id }
#       assigns(:framework).should eq(framework)
#     end

#     it "renders the :new view" do
#       get :new
#       expect(response).to render_template :new
#     end
#   end

#   describe 'POST create' do

#     context "valid attributes" do
#       let(:framework) { FactoryGirl.create(:framework) }
#       # let(:sub_question) { FactoryGirl.create(:sub_question) }
#       let(:performance_indicator) { FactoryGirl.create(:performance_indicator) }

#       it "creates a new evaluative_question" do
#         valid_attributes =
#           {
#             :category => "efficiency",
#             :description => "Porro ullam reiciendis est consequatur quia minus possimus odit.",
#             :framework_id => framework.id,
#             [
#               :description,
#               :definition,
#             ]
#           }
#         expect{
#           post :create, params: { evaluative_question: valid_attributes }
#         }.to change(EvaluativeQuestion, :count).by(1)
#       end

#       it "redirects to new_evaluative_question_path" do
#         valid_attributes =
#           {
#             :category => "efficiency",
#             :description => "Porro ullam reiciendis est consequatur quia minus possimus odit.",
#             :framework_id => framework.id,
#             sub_questions_attributes:
#             [
#               :description => sub_question.description,
#               :monitoring_information => sub_question.monitoring_information
#             ]
#           }
#         post :create, params: { evaluative_question: valid_attributes }
#         expect(response).to redirect_to edit_performance_indicators_evaluative_question_path(id: EvaluativeQuestion.last.id)
#       end
#     end

#     context "with invalid attributes" do
#       it "does not save the new framework" do
#         invalid_attributes = { :framework_id => "abc" }
#         expect{
#           post :create, params: { evaluative_question: invalid_attributes }
#         }.to_not change(EvaluativeQuestion, :count)
#       end

#       it "re-renders the new method" do
#         invalid_attributes = { :framework_id => "abc" }
#         post :create, params: { evaluative_question: invalid_attributes }
#         response.should render_template :new
#       end
#     end
#   end

#   describe "GET #edit" do
#     let(:evaluative_question){ FactoryGirl.create(:evaluative_question) }

#     it "assigns the requested Framework" do
#       get :edit, params: { id: evaluative_question.id }
#       expect(assigns(:evaluative_question)).to eq(evaluative_question)
#     end

#     it "renders the :edit view" do
#       get :edit, params: { id: evaluative_question.id }
#       expect(response).to render_template :edit
#     end
#   end

#   describe 'PUT update' do
#     let(:evaluative_question) { FactoryGirl.create(:evaluative_question) }

#     context "valid attributes" do
#       let(:evaluative_question){ FactoryGirl.create(:evaluative_question) }

#       it "locates the requested evaluative_question" do
#         put :update, params: { id: evaluative_question.id, evaluative_question: FactoryGirl.attributes_for(:evaluative_question) }
#         expect(assigns(:evaluative_question)).to eq(evaluative_question)
#       end

#       it "changes the evaluative_question's attributes" do
#         valid_attributes = { :category => "new category" }
#         put :update, params: { id: evaluative_question.id, evaluative_question: valid_attributes }
#         evaluative_question.reload
#         expect(evaluative_question.category).to eq('new category')
#       end

#       it "redirects to evaluative_question_path" do
#         valid_attributes = { :category => "new category" }
#         put :update, params: { id: evaluative_question.id, evaluative_question: valid_attributes }
#         expect(response).to redirect_to edit_performance_indicators_evaluative_question_path(evaluative_question)
#       end
#     end

#     context "invalid attributes" do
#       let(:evaluative_question){ FactoryGirl.create(:evaluative_question) }

#       it "locates the requested evaluative_question" do
#         invalid_attributes = { :framework_id => "abc" }
#         put :update, params: { id: evaluative_question.id, evaluative_question: invalid_attributes }
#         expect(assigns(:evaluative_question)).to eq(evaluative_question)
#       end

#       it "changes the evaluative_question's attributes" do
#         invalid_attributes = { :framework_id => "abc" }
#         put :update, params: { id: evaluative_question.id, evaluative_question: invalid_attributes }
#         expect(evaluative_question.category).to_not eq(1)
#       end

#       it "redirects to evaluative_questions_path" do
#         invalid_attributes = { :framework_id => "abc" }
#         put :update, params: { id: evaluative_question.id, evaluative_question: invalid_attributes }
#         expect(response).to render_template :edit
#       end
#     end
#   end
# end
