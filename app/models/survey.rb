class Survey < ApplicationRecord
  has_many :data_questions, inverse_of: :survey
  belongs_to :survey_template, inverse_of: :surveys

end
