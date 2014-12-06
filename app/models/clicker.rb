class Clicker < ActiveRecord::Base
  belongs_to :course
  belongs_to :author, foreign_key: 'user_id', class_name: 'User'

  has_many :choices, foreign_key: 'clicker_id', class_name: 'ClickerChoice'

  validates :privacy, inclusion: { in: ['all', 'none', 'professor'] }
  validates :type, inclusion: { in: ['ox', 'star', 'mult2', 'mult3', 'mult4', 'mult5', 'essay'] }

  validates_presence_of :type, :time_length, :privacy

  self.inheritance_column = :_type
end
