class Course < ActiveRecord::Base
  belongs_to :school

  validates :name, presence: true
  validates :open, presence: true
  validates :code, presence: true, uniqueness: true
  validates :instructor_name, presence: true
end
