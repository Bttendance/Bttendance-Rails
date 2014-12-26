class ClickerChoice < ActiveRecord::Base
  belongs_to :clicker
  belongs_to :user

  validates :choice, presence: true, inclusion: {
    in: ['o', 'x', 'star1', 'star2', 'star3', 'star4', 'star5', 'a', 'b', 'c', 'd', 'e', 'text']
  }
  validates :message, presence: true
end
