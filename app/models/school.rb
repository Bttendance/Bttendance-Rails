class School < ActiveRecord::Base
  has_many :user_schools
  has_many :users, through: :user_schools
  has_many :courses

  accepts_nested_attributes_for :courses, allow_destroy: true

  before_validation { classification.downcase! }
  validates :name, presence: true, length: { maximum: 255 }
  validates :classification, presence: true, inclusion: { in: ['university', 'school', 'institute', 'other'] }
end
