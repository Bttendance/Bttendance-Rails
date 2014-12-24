class Preferences < ActiveRecord::Base
  belongs_to :user
  validates :clicker, presence: true
  validates :attendance, presence: true
  validates :curious, presence: true
  validates :notice, presence: true
  validates :following, presence: true
end
