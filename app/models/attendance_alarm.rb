class AttendanceAlarm < ActiveRecord::Base
  belongs_to :course
  belongs_to :schedule
  belongs_to :author, foreign_key: 'user_id', class_name: 'User'
end
