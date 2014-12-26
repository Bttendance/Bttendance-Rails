class Preferences < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :clicker, :attendance, :curious, :following, :notice
end
