require 'rails_helper'

describe 'frameworks/index.html.haml' do
  context 'when there is a framework' do
    let(:framework) { FactoryGirl.create(:framework) }
    it 'displays a list of frameworks' do

      assign(:frameworks, [framework])

      render

      expect(rendered).to include(framework.name)
    end
  end

  context 'when there is no framework' do
    it 'displays a message' do

      assign(:frameworks, [])

      render

      expect(rendered).to include('No frameworks have been created.')
    end
  end
end