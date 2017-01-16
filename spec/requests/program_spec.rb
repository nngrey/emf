require "rails_helper"

RSpec.describe "Program", :type => :request do
  let(:organization){FactoryGirl.create(:organization)}

  it "creates a program and redirects to new logic_model_input page" do
    get "/organizations/#{organization.id}/programs/new"
    expect(response).to render_template(:new)
    post "/organizations/#{organization.id}/programs", :program => {:name => "Test program"}
    expect(response).to redirect_to(new_inputs_logic_model_path(assigns(:program).logic_model))
    follow_redirect!
    expect(response).to render_template(:new_inputs)
    expect(response.body).to include("Add inputs")
  end

  it "does not render a different template" do
    get "/organizations/#{organization.id}/programs/new"
    expect(response).to_not render_template(:show)
  end
end