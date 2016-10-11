class AddFrameworkToEvaluativeQuestions < ActiveRecord::Migration[5.0]
  def change
    add_reference :evaluative_questions, :framework, foreign_key: true
  end
end
