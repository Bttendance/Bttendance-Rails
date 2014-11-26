class School < ActiveRecord::Base
  attr_accessor :name

  has_many :user_schools
  has_many :users, through: :user_schools

  validates :name, presence: true, length: { maximum: 255 }
  validates :type, presence: true, inclusion: { in: ['university', 'school', 'institute', 'other'] }
end
