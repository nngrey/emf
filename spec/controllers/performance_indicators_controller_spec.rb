require 'rails_helper'

RSpec.describe PerformanceIndicatorsController, type: :controller do

  describe "GET #index" do
    let(:evaluative_question){ FactoryGirl.create(:evaluative_question) }

    it "populates an array of evaluative_questions" do
      get :index
      expect(assigns(:evaluative_questions)).to eq([evaluative_question])
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #edit" do
    let(:performance_indicator){ FactoryGirl.create(:performance_indicator) }

    it "populates an array of evaluative_questions" do
      get :edit, params: { id: performance_indicator.id }
      expect(assigns(:performance_indicator)).to eq(performance_indicator)
    end

    it "renders the :index view" do
      get :edit, params: { id: performance_indicator.id }
      expect(response).to render_template :edit
    end
  end

  describe 'PUT update' do

    context "valid attributes" do
      let(:performance_indicator){ FactoryGirl.create(:performance_indicator) }

      it "locates the requested performance_indicator" do
        put :update, params: { id: performance_indicator.id, performance_indicator: { numerator: nil, denominator: nil } }
        expect(assigns(:performance_indicator)).to eq(performance_indicator)
      end

      it "changes the performance indicator's attributes" do
        put :update, params: { id: performance_indicator.id, performance_indicator: { numerator: 10, denominator: 11 } }
        performance_indicator.reload
        expect(performance_indicator.numerator).to eq(10)
        expect(performance_indicator.denominator).to eq(11)
      end

      it "redirects to performance_indicators_path" do
        put :update, params: { id: performance_indicator.id, performance_indicator: { numerator: 10, denominator: 11 } }
        expect(response).to redirect_to performance_indicators_path
      end
    end

    context "invalid attributes" do
      let(:performance_indicator){ FactoryGirl.create(:performance_indicator) }

      it "locates the requested performance_indicator" do
        put :update, params: { id: performance_indicator.id, performance_indicator: { numerator: 'abc', denominator: 'xyz' } }
        expect(assigns(:performance_indicator)).to eq(performance_indicator)
      end

      it "changes the performance indicator's attributes" do
        put :update, params: { id: performance_indicator.id, performance_indicator: { numerator: 'abc', denominator: 'xyz' } }
        performance_indicator.reload
        expect(performance_indicator.numerator).to_not eq('abc')
        expect(performance_indicator.denominator).to_not eq('xyz')
      end

      it "redirects to performance_indicators_path" do
        put :update, params: { id: performance_indicator.id, performance_indicator: { numerator: true, denominator: false } }
        expect(response).to render_template :edit
      end
    end

    describe "GET #dashboard" do
      let(:performance_indicator){ FactoryGirl.create(:performance_indicator) }

      it "populates an array of performance_indicators" do
        get :dashboard
        expect(assigns(:performance_indicators)).to eq([performance_indicator])
      end

      it "renders the :dashboard view" do
        get :dashboard
        expect(response).to render_template :dashboard
      end
    end
  end
end
