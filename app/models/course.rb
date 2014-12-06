class Course < ActiveRecord::Base
  belongs_to :school

  has_many :courses_users
  has_many :users, through: :courses_users
  has_many :schedules
  has_many :alarms, foreign_key: 'attendance_alarm_id', class_name: 'AttendanceAlarm'
  has_many :attendances
  has_many :clickers

  validates :name, presence: true
  validates :open, inclusion: { in: [true, false] }
  validates :code, presence: true, uniqueness: true
  validates :instructor_name, presence: true
end
