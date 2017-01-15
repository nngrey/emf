require "rails_helper"

describe "rendering the new organization form", type: :request do
  it "it renders organizations#new" do
    get new_organization_path
    assert_response :success
  end
end