class AttendancesUser < ActiveRecord::Base
  belongs_to :attendance
  belongs_to :user

  # Limit one instance of a (the same) attendance per user
  validates :attendance_id, uniqueness: { scope: :user_id }
  validates :state, presence: true, inclusion: {
    in: ['attended', 'tardy', 'absent', 'claimed']
  }

  # Set a primary key so we can use standard ActiveRecord methods
  self.primary_key = :user_id
end
