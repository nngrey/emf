class FrameworksController < ApplicationController

  def overview
    @evaluative_questions = EvaluativeQuestion.all
  end

end