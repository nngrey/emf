require "rails_helper"

describe "rendering the new program form", type: :request do
  let(:organization){ FactoryGirl.create(:organization) }

  it "renders programs#new" do
    get new_organization_program_path(organization)
    assert_response :success
  end
end