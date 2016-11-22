class AddDisplayAsToDataQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :data_questions, :display_value, :string, :default => "Do not display"
  end
end
