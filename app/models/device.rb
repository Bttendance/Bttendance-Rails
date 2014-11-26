class Device < ActiveRecord::Base
  belongs_to :user

  before_validation { platform.downcase! }
  validates :uuid, uniqueness: true
  validates :platform, presence: true, inclusion: { in: ['ios', 'android', 'xiaomi'] }
end
