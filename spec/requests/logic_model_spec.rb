require "rails_helper"

RSpec.describe "Logic Model", :type => :request do
  let(:logic_model){FactoryGirl.create(:logic_model)}

  it "creates a logic_model_input and redirects to the activities page" do
    get "/logic_models/#{logic_model.id}/new_inputs"
    expect(response).to render_template(:new_inputs)
    patch "/logic_models/#{logic_model.id}/create_inputs",
      :logic_model =>
        {:logic_model_inputs_attributes =>
          {'0' =>
            {:description => "input description"}
          }
        }
    expect(response).to redirect_to(new_logic_model_activity_path(logic_model))
    follow_redirect!
    expect(response).to render_template(:new)
    expect(response.body).to include("Add activities")
  end

  it "does not render a different template" do
    get "/logic_models/#{logic_model.id}/new_inputs"
    expect(response).to_not render_template(:new_outputs)
  end
end