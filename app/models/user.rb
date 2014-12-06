class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :schools_users
  has_many :schools, through: :schools_users
  has_many :courses_users
  has_many :courses, through: :courses_users
  has_many :devices
  has_many :alarms, foreign_key: 'user_id', class_name: 'AttendanceAlarm'
  has_many :attendances
  has_many :attendances_users
  has_many :attendeds, through: :attendances_users, foreign_key: 'attendance_id', class_name: 'Attendance', source: :attendance
  has_many :clickers
  has_many :clicker_choices
  has_many :notices
  has_many :notice_targets
  has_many :curious
  has_many :likes
  has_many :comments
  has_many :subscriptions, foreign_key: 'user_id', class_name: 'Follower'
  has_many :notifications

  accepts_nested_attributes_for :devices, :schools_users, allow_destroy: true

  before_save { email.downcase! }
  validates :locale, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }, on: :create
end
