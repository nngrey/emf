class RenameTypeQuestionType < ActiveRecord::Migration[5.0]
  def change
    rename_column :data_questions, :type, :question_type
  end
end
