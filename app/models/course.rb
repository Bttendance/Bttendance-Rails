class Course < ActiveRecord::Base
  belongs_to :school

  has_many :courses_users
  has_many :users, through: :courses_users
  has_many :schedules
  has_many :alarms, foreign_key: 'course_id', class_name: 'AttendanceAlarm'
  has_many :attendances
  has_many :clickers
  has_many :notices
  has_many :curiouses
  has_many :notifications

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :instructor_name, presence: true

  before_validation :create_random_code, on: :create
  before_validation :initialize_open, on: :create

  def attending_users_count
    self.courses_users.where(state: 'attending').count
  end

  def create_random_code
    self.code = Array.new(4){[*"A".."Z", *"0".."9"].sample}.join
    Rails.logger.debug(self.code)
  end

  def initialize_open
    self.open = true
  end

end
