class SubQuestionsController < ApplicationController

  def create

  end

  private
  def evaluative_question_params
    params.require(:sub_question).permit(
      :description,
      :monitoring_information
      )
  end

end