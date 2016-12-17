class Program < ApplicationRecord
  belongs_to :organization
  has_one :framework
  has_one :logic_model

  def question_category
    category = 'appropriateness'
    if self.framework.evaluative_questions.any?
      if self.framework.evaluative_questions.find_by(category: 'appropriateness').present?
        category = 'effectiveness'
      end
      if self.framework.evaluative_questions.find_by(category: 'effectiveness').present?
        category = 'efficiency'
      end
      if self.framework.evaluative_questions.find_by(category: 'efficiency').present?
        category = 'impact'
      end
      if self.framework.evaluative_questions.find_by(category: 'impact').present?
        category = 'sustainability'
      end
      if self.framework.evaluative_questions.find_by(category: 'sustainability').present?
        category = 'complete'
      end
    end
    category
  end

  def correct_category(category)
    next_category = 'effectiveness'
    if category == 'effectiveness'
      next_category = 'efficiency'
    end
    if category == 'efficiency'
      next_category = 'impact'
    end
    if category == 'impact'
      next_category = 'sustainability'
    end
    if category == 'sustainability'
      next_category = 'complete'
    end
    next_category
  end
end
