require "rails_helper"

RSpec.describe "EvaluativeQuestion", :type => :request do
  let(:program){FactoryGirl.create(:program)}
  let(:framework){FactoryGirl.create(:framework, program: program)}
  let(:collection_date){FactoryGirl.create(:collection_date)}
  let(:performance_indicator){FactoryGirl.create(:performance_indicator, collection_dates: [collection_date])}
  let(:evaluative_question){FactoryGirl.create(:evaluative_question, framework: framework, performance_indicators: [performance_indicator])}

  it "creates an evaluative question and redirects to the framework show page when the framework is complete" do
    get "/frameworks/#{framework.id}/evaluative_questions/new",
      params:
        {
          current_category: "appropriateness",
          step: "current",
          framework_id: "1"
        }
    expect(response).to render_template(:new)

    post "/frameworks/#{framework.id}/evaluative_questions",
      params:
        {evaluative_question:
          { category: "appropriateness",
            description: "description",
            performance_indicators_attributes:
            { '0':
              { description: "description",
                data_source: "data_source",
                collection_dates_attributes:
                { '0':
                  { date: "01/02/2017" }
                }
              }
            }
          },
          commit: 'Finish'
        }
    expect(response).to redirect_to(framework_path(assigns(:framework)))
    follow_redirect!
    expect(response).to render_template(:show)
    framework = assigns(:framework)
    expect(response.body).to include("Evaluative framework for #{framework.program.name}")
  end

  it "creates an evaluative question and redirects to evaluative_question show page" do
    post "/frameworks/#{framework.id}/evaluative_questions",
      params:
        {evaluative_question:
          { category: "appropriateness",
            description: "description",
            performance_indicators_attributes:
            { '0':
              { description: "description",
                data_source: "data_source",
                collection_dates_attributes:
                { '0':
                  { date: "01/02/2017" }
                }
              }
            }
          },
          commit: 'Save and continue'
        }
    expect(response).to redirect_to(evaluative_question_path(assigns(:evaluative_question)))
    follow_redirect!
    expect(response).to render_template(:show)
    expect(response.body).to include("Review")
  end

  it "renders the new template if it cannot create an evaluative question" do
    post "/frameworks/#{framework.id}/evaluative_questions",
      params:
        {evaluative_question:
          { category: "appropriateness",
            description: nil,
            performance_indicators_attributes:
            { '0':
              { description: "description",
                data_source: "data_source",
                collection_dates_attributes:
                { '0':
                  { date: "01/02/2017" }
                }
              }
            }
          },
          commit: 'Save and continue'
        }
    expect(response).to render_template(:new)
  end

  it "updates an evaluative question and redirects to the framework show page" do
    get "/evaluative_questions/#{evaluative_question.id}/edit",
      params:
        {
          id: evaluative_question.id
        }
    expect(response).to render_template(:edit)

    patch "/evaluative_questions/#{evaluative_question.id}",
      params:
        {evaluative_question:
          { category: "appropriateness",
            description: "edited description",
            performance_indicators_attributes:
            { '0':
              { description: "description",
                data_source: "data_source",
                collection_dates_attributes:
                { '0':
                  { date: "01/02/2017" }
                }
              }
            }
          }
        }
    expect(response).to redirect_to(framework_path(assigns(:evaluative_question).framework))
    follow_redirect!
    expect(response).to render_template(:show)
    expect(response.body).to include("edited description")
  end
end