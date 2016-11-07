class AddEvaluativeQuestionReferenceToPerformanceIndicators < ActiveRecord::Migration[5.0]
  def change
    add_reference :performance_indicators, :evaluative_question, foreign_key: true
  end
end
