class NoticeTarget < ActiveRecord::Base
  belongs_to :notice
  belongs_to :user
end
