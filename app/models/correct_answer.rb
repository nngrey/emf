class CorrectAnswer < ApplicationRecord
  belongs_to :data_question
  belongs_to :survey
end
