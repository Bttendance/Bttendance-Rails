class Attendance < ActiveRecord::Base
  belongs_to :course
  belongs_to :author, foreign_key: 'user_id', class_name: 'User'

  has_many :attendances_users
  has_many :users, through: :attendances_users
end
