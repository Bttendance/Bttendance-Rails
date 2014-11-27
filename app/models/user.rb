class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :schools_users
  has_many :schools, through: :schools_users
  has_many :course_users
  has_many :courses, through: :courses_users
  has_many :devices

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
