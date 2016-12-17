class Option < ApplicationRecord
  belongs_to :data_question, inverse_of: :options
end
