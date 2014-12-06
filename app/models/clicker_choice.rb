class ClickerChoice < ActiveRecord::Base
  belongs_to :clicker
  belongs_to :user

  validates :choice, presence: true, inclusion: {
    in: ['o', 'x', '1', '2', '3', '4', '5', 'a', 'b', 'c', 'd', 'e', 'text']
  }
  validates :message, presence: true
end
