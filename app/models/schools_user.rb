class SchoolsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :school

  validates :identity, presence: true
end
