class Preferences < ActiveRecord::Base
  belongs_to :user

  validates_inclusion_of :clicker, :attendance, :curious, :following, :notice, :in => [true, false]
end
