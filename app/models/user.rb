class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable

  has_many :schools_users
  has_many :schools, through: :schools_users
  has_many :courses_users
  has_many :courses, through: :courses_users
  has_many :devices
  has_many :alarms, foreign_key: 'user_id', class_name: 'AttendanceAlarm'
  has_many :attendances
  has_many :attendances_users
  has_many :attendeds, through: :attendances_users,
                       foreign_key: 'attendance_id',
                       class_name: 'Attendance',
                       source: :attendance
  has_many :clickers
  has_many :clicker_choices
  has_many :notices
  has_many :notice_targets
  has_many :curiouses
  has_many :likes
  has_many :comments
  has_many :subscriptions, foreign_key: 'user_id', class_name: 'Follower'
  has_many :notifications

  has_one :preferences

  accepts_nested_attributes_for :preferences
  accepts_nested_attributes_for :devices, :schools_users, allow_destroy: true

  before_save { email.downcase! }
  validates :locale, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }, on: :create

  # Model callbacks
  before_create :set_locale
  after_create  :create_preferences,
                :send_welcome_email

  def set_locale
    self.locale = I18n.locale || 'en'
  end

  def create_preferences
    Preferences.create(user_id: self.id)
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver
  end

  def from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
