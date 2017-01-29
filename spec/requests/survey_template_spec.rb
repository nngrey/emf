require "rails_helper"

RSpec.describe "Survey Template", :type => :request do
  let(:framework){FactoryGirl.create(:framework)}

  it "creates a survey_template_input and redirects to the activities page" do
    get "/frameworks/#{framework.id}/survey_templates/new"
    expect(response).to render_template(:new)
    post "/frameworks/#{framework.id}/survey_templates",
      params:
        { survey_template:
          { name: 'Survey 1'},
          commit: 'Continue'
        }
    expect(response).to redirect_to(new_survey_template_data_question_path(assigns(:survey_template)))
    # follow_redirect!
    # expect(response).to render_template(:new)
    # expect(response.body).to include("Add activities")
  end


  # :name,
  # data_questions_attributes:
  # [
  #   :id,
  #   :description,
  #   :question_type,
  #   :_destroy,
  #   options_attributes:
  #   [
  #     :id,
  #     :description,
  #     :_destroy,


  # ##TODO add tests for rendering the new template if save fails

  # it "does not render a different template" do
  #   get "/survey_templates/#{survey_template.id}/new_inputs"
  #   expect(response).to_not render_template(:new_outputs)
  # end

  # it "creates an output and redirects to the new outcome page" do
  #   get "/survey_templates/#{survey_template.id}/new_outputs"
  #   expect(response).to render_template(:new_outputs)
  #   patch "/survey_templates/#{survey_template.id}/create_outputs",
  #     params:
  #       {survey_template:
  #         {outputs_attributes:
  #           {'0':
  #             {description: "create_outputs description"}
  #           }
  #         }
  #       }
  #   expect(response).to redirect_to(new_outcomes_survey_template_path(survey_template))
  #   follow_redirect!
  #   expect(response).to render_template(:new_outcomes)
  #   expect(response.body).to include("Add outcomes")
  # end

  # it "does not render a different template" do
  #   get "/survey_templates/#{survey_template.id}/new_outcomes"
  #   expect(response).to_not render_template(:new_outputs)
  # end

  # it "creates an outcome and redirects to the new impact page" do
  #   get "/survey_templates/#{survey_template.id}/new_outcomes"
  #   expect(response).to render_template(:new_outcomes)
  #   patch "/survey_templates/#{survey_template.id}/create_outcomes",
  #     params:
  #       {survey_template:
  #         {outcomes_attributes:
  #           {'0':
  #             {description: "create_outcomes description"}
  #           }
  #         }
  #       }
  #   expect(response).to redirect_to(new_impacts_survey_template_path(survey_template))
  #   follow_redirect!
  #   expect(response).to render_template(:new_impacts)
  #   expect(response.body).to include("Add impacts")
  # end

  # it "does not render a different template" do
  #   get "/survey_templates/#{survey_template.id}/new_impacts"
  #   expect(response).to_not render_template(:new_outputs)
  # end
end