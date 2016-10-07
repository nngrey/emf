class FrameworksController < ApplicationController

  def overview
    @effectiveness_questions = EvaluativeQuestion.where(category: 'effectiveness')
  end

end