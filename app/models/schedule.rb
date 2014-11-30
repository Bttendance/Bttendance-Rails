class Schedule < ActiveRecord::Base
  belongs_to :course

  has_many :alarms, foreign_key: 'attendance_alarm_id', class_name: 'AttendanceAlarm'

  validates :day_of_week, presence: true, inclusion: { in: ['mon', 'tue', 'wed', 'thu', 'fri', 'sat'] }
  validates :time, presence: true
  validates :timezone, presence: true
end
