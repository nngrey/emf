require 'rails_helper'

describe 'frameworks/show.html.haml' do
  context 'when there is a framework' do
    let(:evaluative_question) { FactoryGirl.create(:evaluative_question) }
    it 'displays a button to view as a list' do

      assign(:framework, FactoryGirl.create(:framework))
      assign(:evaluative_questions, [evaluative_question])
      assign(:view_as, 'list')

      render

      expect(rendered).to include('View as list')
    end
  end

  context 'when there is no framework' do
    it 'displays a message' do

      assign(:evaluative_questions, [])

      render

      expect(rendered).to include('This is where the framework will appear after it has been built.')
    end
  end
end