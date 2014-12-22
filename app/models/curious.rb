class Curious < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  has_many :likes, as: :likeable
  has_many :followers, as: :followable
  has_many :comments, as: :commentable
  has_many :notifications, as: :notifiable

  validates_presence_of :title, :message
end
