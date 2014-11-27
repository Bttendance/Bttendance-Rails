class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :user_schools
  has_many :schools, through: :user_schools
  has_many :user_courses
  has_many :courses, through: :user_courses
  has_many :devices

  accepts_nested_attributes_for :devices, allow_destroy: true

  before_save { email.downcase! }
  validates :locale, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }
end
