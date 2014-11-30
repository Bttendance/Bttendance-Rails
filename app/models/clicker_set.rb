class ClickerSet < ActiveRecord::Base
  belongs_to :course
  belongs_to :author, foreign_key: 'user_id', class_name: 'User'

  validates :privacy, inclusion: { in: ['all', 'none', 'professor'] }

  self.inheritance_column = :_type
end
