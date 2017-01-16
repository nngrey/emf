require "rails_helper"

RSpec.describe "Organization", :type => :request do

  it "creates an organization and redirects to the show page" do
    get "/organizations/new"
    expect(response).to render_template(:new)

    post "/organizations", :organization => {:name => "New organization"}

    expect(response).to redirect_to(assigns(:organization))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.body).to include("Dashboard for New organization")
  end

  it "does not render a different template" do
    get "/organizations/new"
    expect(response).to_not render_template(:show)
  end
end