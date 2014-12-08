class Notice < ActiveRecord::Base
  belongs_to :course
  belongs_to :author, foreign_key: 'user_id', class_name: 'User'

  has_many :notice_targets
  has_many :notifications, as: :notifiable

  accepts_nested_attributes_for :notice_targets

  validates_presence_of :targeted, :message
end
