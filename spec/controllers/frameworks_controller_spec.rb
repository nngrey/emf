require 'rails_helper'

RSpec.describe FrameworksController, type: :controller do

  describe "GET #index" do
    let(:framework){ FactoryGirl.create(:framework) }

    it "populates an array of frameworks" do
      get :index
      expect(assigns(:frameworks)).to eq([framework])
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    let(:framework){ FactoryGirl.create(:framework) }

    it "assigns the requested framework" do
      get :show, params: { id: framework.id }
      assigns(:framework).should eq(framework)
    end

    it "assigns the associated evaluative_questions" do
      get :show, params: { id: framework.id }
      assigns(:evaluative_questions).should eq(framework.evaluative_questions)
    end

    it "assigns view_as when there is a param" do
      get :show, params: { id: framework.id, view_as: 'table' }
      assigns(:view_as).should eq('table')
    end

    it "assigns view_as as 'list' when there is no param" do
      get :show, params: { id: framework.id }
      assigns(:view_as).should eq('list')
    end

    it "renders the #show view" do
      get :show, params: { id: framework.id }
      response.should render_template :show
    end
  end

  describe "GET #new" do
    it "renders the :new view" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do

    context "valid attributes" do
      it "creates a new framework" do
        expect{
          post :create, framework: FactoryGirl.attributes_for(:framework)
        }.to change(Framework, :count).by(1)
      end

      it "redirects to new_evaluative_question_path" do
        post :create, framework: FactoryGirl.attributes_for(:framework)
        expect(response).to redirect_to new_evaluative_question_path(framework_id: Framework.last.id)
      end
    end

    context "with invalid attributes" do
      it "does not save the new framework" do
        expect{
          post :create, framework: { name: nil }
        }.to_not change(Framework, :count)
      end

      it "re-renders the new method" do
        post :create, framework: { name: nil }
        response.should render_template :new
      end
    end
  end

  describe "GET #edit" do
    let(:framework){ FactoryGirl.create(:framework) }

    it "assigns the requested Framework" do
      get :edit, params: { id: framework.id }
      expect(assigns(:framework)).to eq(framework)
    end

    it "renders the :edit view" do
      get :edit, params: { id: framework.id }
      expect(response).to render_template :edit
    end
  end

  describe 'PUT update' do

    context "valid attributes" do
      let(:framework){ FactoryGirl.create(:framework) }

      it "locates the requested framework" do
        put :update, params: { id: framework.id, framework: { name: nil } }
        expect(assigns(:framework)).to eq(framework)
      end

      it "changes the framework's attributes" do
        put :update, params: { id: framework.id, framework: { name: 'bob' } }
        framework.reload
        expect(framework.name).to eq('bob')
      end

      it "redirects to framework_path" do
        put :update, params: { id: framework.id, framework: { name: 'bob' } }
        expect(response).to redirect_to framework_path(framework)
      end
    end

    context "invalid attributes" do
      let(:framework){ FactoryGirl.create(:framework) }

      it "locates the requested framework" do
        put :update, params: { id: framework.id, framework: { name: nil } }
        expect(assigns(:framework)).to eq(framework)
      end

      it "does not change the framework's attributes" do
        put :update, params: { id: framework.id, framework: { name: 1 } }
        framework.reload
        expect(framework.name).to_not eq(1)
      end

      it "redirects to renders the edit template" do
        put :update, params: { id: framework.id, framework: { name: nil } }
        expect(response).to render_template :edit
      end
    end
  end
end
