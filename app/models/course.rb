class Course < ActiveRecord::Base
  belongs_to :school

  has_many :user_courses
  has_many :users, through: :user_courses

  validates :name, presence: true
  validates :open, inclusion: { in: [true, false] }
  validates :code, presence: true, uniqueness: true
  validates :instructor_name, presence: true
end
