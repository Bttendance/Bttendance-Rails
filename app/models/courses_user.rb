class CoursesUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  # Limit one instance of a (the same) course per user
  validates :course_id, uniqueness: { scope: :user_id }
  validates :state, presence: true, inclusion: {
    in: ['supervising', 'assisting', 'attending', 'dropped', 'kicked']
  }

  # Set a primary key so we can use standard ActiveRecord methods
  self.primary_key = :course_id
end
