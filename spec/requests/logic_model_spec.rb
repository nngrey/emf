require "rails_helper"

RSpec.describe "Logic Model", :type => :request do
  let(:logic_model){FactoryGirl.create(:logic_model)}

  it "creates a logic_model_input and redirects to the activities page" do
    get "/logic_models/#{logic_model.id}/new_inputs"
    expect(response).to render_template(:new_inputs)
    patch "/logic_models/#{logic_model.id}/create_inputs",
      params:
        {logic_model:
          {logic_model_inputs_attributes:
            {'0':
              {description: "input description"}
            }
          }
        }
    expect(response).to redirect_to(new_logic_model_activity_path(logic_model))
    follow_redirect!
    expect(response).to render_template(:new)
    expect(response.body).to include("Add activities")
  end

  ##TODO add tests for rendering the new template if save fails

  it "does not render a different template" do
    get "/logic_models/#{logic_model.id}/new_inputs"
    expect(response).to_not render_template(:new_outputs)
  end

  it "creates an output and redirects to the new outcome page" do
    get "/logic_models/#{logic_model.id}/new_outputs"
    expect(response).to render_template(:new_outputs)
    patch "/logic_models/#{logic_model.id}/create_outputs",
      params:
        {logic_model:
          {outputs_attributes:
            {'0':
              {description: "create_outputs description"}
            }
          }
        }
    expect(response).to redirect_to(new_outcomes_logic_model_path(logic_model))
    follow_redirect!
    expect(response).to render_template(:new_outcomes)
    expect(response.body).to include("Add outcomes")
  end

  it "does not render a different template" do
    get "/logic_models/#{logic_model.id}/new_outcomes"
    expect(response).to_not render_template(:new_outputs)
  end

  it "creates an outcome and redirects to the new impact page" do
    get "/logic_models/#{logic_model.id}/new_outcomes"
    expect(response).to render_template(:new_outcomes)
    patch "/logic_models/#{logic_model.id}/create_outcomes",
      params:
        {logic_model:
          {outcomes_attributes:
            {'0':
              {description: "create_outcomes description"}
            }
          }
        }
    expect(response).to redirect_to(new_impacts_logic_model_path(logic_model))
    follow_redirect!
    expect(response).to render_template(:new_impacts)
    expect(response.body).to include("Add impacts")
  end

  it "does not render a different template" do
    get "/logic_models/#{logic_model.id}/new_impacts"
    expect(response).to_not render_template(:new_outputs)
  end
end