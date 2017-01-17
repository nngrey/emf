require "rails_helper"

RSpec.describe "Actiity", :type => :request do
  let(:logic_model){FactoryGirl.create(:logic_model)}

  it "creates an activity and redirects to the show page" do
    get "/logic_models/#{ logic_model.id }/activities/new"
    expect(response).to render_template(:new)

    post "/logic_models/#{ logic_model.id }/activities",
      :activity => {name: "New activity", description: "Activity description"}, :commit => "Save and continue"

    expect(response).to redirect_to(assigns(:activity))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.body).to include("Review")
  end

  it "does not render a different template" do
    get "/logic_models/#{ logic_model.id }/activities/new"
    expect(response).to_not render_template(:show)
  end
end

##TODO add tests for rendering the new template if save fails
