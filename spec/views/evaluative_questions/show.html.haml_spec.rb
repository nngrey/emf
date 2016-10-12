require 'rails_helper'

describe 'evaluative_questions/show.html.haml' do
  context 'when there is an evaluative_question' do
    it 'displays a button to view as a list' do

      assign(:evaluative_question, FactoryGirl.create(:evaluative_question))
      assign(:view_as, 'list')

      render

      expect(rendered).to include('View as list')
    end
  end

  context 'when there is no evaluative_question' do
    it 'displays a message' do

      render

      expect(rendered).to_not include('View as list')
      expect(rendered).to include('This is where the framework will appear after it has been built.')
    end
  end
end