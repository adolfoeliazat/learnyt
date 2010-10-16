class Question < ActiveRecord::Base
  # Associations
  has_many :possible_answers
  accepts_nested_attributes_for :possible_answers
  
  has_many :answers, :through => :possible_questions
  accepts_nested_attributes_for :answers

  # Helpers
  def to_s
    title
  end
end
