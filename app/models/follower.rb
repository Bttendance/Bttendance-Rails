class Follower < ActiveRecord::Base
  belongs_to :followable, polymorphic: true
  belongs_to :user

  validates_presence_of :user_id
end
