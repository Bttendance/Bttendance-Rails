class School < ActiveRecord::Base
  has_many :schools_users
  has_many :users, through: :schools_users
  has_many :courses

  accepts_nested_attributes_for :courses, allow_destroy: true

  before_validation { classification.downcase! }
  validates :name, presence: true, length: { maximum: 255 }
  validates :classification, presence: true, inclusion: { in: ['university', 'school', 'institute', 'other'] }

  scope :name_like, ->(search) { where("lower(name) LIKE ?", "%#{search.downcase}%") }

  def users_count
    self.schools_users.count
  end

  def courses_count
    self.courses.count
  end
end
