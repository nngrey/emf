class Program < ApplicationRecord
  belongs_to :organization
  has_one :framework
  has_one :logic_model

  validates :name, uniqueness: true

  def question_hints(category)
    if category == 'appropriateness'
      hint = "You should include evaluative questions that measure the
        relevance or appropriateness of your program to the target population,
        such as 'Does the target population agree that the problem should be addressed?' and
        'Does the target population agree with the proposed solution?'"
    end
    hint
  end

  def indicator_hints(category)
    if category == 'appropriateness'
      hint = "Performance indicators describe how you will answer an evaluative question,
        such as 'The percentage of the target population who agree that the problem should be addressed' and
        'The percentage of the target population who agree with the proposed solution'. You should have one
        or more performance indicators for each evaluative question."
    end
    hint
  end

  def correct_category(current_category, step)
    correct_category = 'appropriateness'
    if step == 'current'
      correct_category = current_category
    elsif step == 'next'
      if current_category == 'appropriateness'
        correct_category = 'efficiency'
      end
      if current_category == 'efficiency'
        correct_category = 'effectiveness'
      end
      if current_category == 'effectiveness'
        correct_category = 'impact'
      end
      if current_category == 'impact'
        correct_category = 'sustainability'
      end
      if current_category == 'sustainability'
        correct_category = 'complete'
      end
    end
    correct_category
  end
end
