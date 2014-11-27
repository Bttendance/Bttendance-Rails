class Course < ActiveRecord::Base
  belongs_to :school

  has_many :courses_users
  has_many :users, through: :courses_users

  validates :name, presence: true
  validates :open, inclusion: { in: [true, false] }
  validates :code, presence: true, uniqueness: true
  validates :instructor_name, presence: true
end
