class DataQuestionsController < ApplicationController

  def update
    @data_question = DataQuestion.find(params[:id])
    @data_question.update(display_value: params[:display_value])
    binding.pry
  end

end
