class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :schools_users
  has_many :schools, through: :schools_users
  has_many :courses_users
  has_many :courses, through: :courses_users
  has_many :devices
  has_many :alarms, foreign_key: 'attendance_alarm_id', class_name: 'AttendanceAlarm'
  has_many :attendances_users
  has_many :attendances, through: :attendances_users
  has_many :clickers
  has_many :clicker_choices
  has_many :notices
  has_many :notice_targets

  accepts_nested_attributes_for :devices, allow_destroy: true
  accepts_nested_attributes_for :schools_users, allow_destroy: true

  before_save { email.downcase! }
  validates :locale, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }, on: :create
end
