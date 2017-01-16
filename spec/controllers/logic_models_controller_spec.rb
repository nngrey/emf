require "rails_helper"

describe "rendering the new program form", type: :request do
  let(:logic_model){FactoryGirl.create(:logic_model)}

  it "renders inputs#new" do
    get new_inputs_logic_model_path(logic_model)
    assert_response :success
  end

  it "renders inputs#create" do
    patch create_inputs_logic_model_path(logic_model)
    assert_response :success
  end
end