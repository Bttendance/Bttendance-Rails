class Device < ActiveRecord::Base
  belongs_to :user

  before_validation { platform.downcase! }
  validates :platform, presence: true, inclusion: { in: ['ios', 'android', 'xiaomi', 'browser'] }
  validates_uniqueness_of :uuid, :allow_nil => true, :allow_blank => true
  validates_uniqueness_of :mac_address, :allow_nil => true, :allow_blank => true
end
