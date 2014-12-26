class CoursesUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  # Limit one instance of a (the same) course per user
  validates :course_id, uniqueness: { scope: :user_id }
  validates :state, presence: true, inclusion: {
    in: ['supervising', 'attending', 'dropped', 'kicked']
  }

  # Set a primary key so we can use standard ActiveRecord methods
  self.primary_key = :user_id

  # Send email to instructor or student
  after_create :send_course_mail

  def send_course_mail
    if self.state == 'supervising'
      UserMailer.create_course(self).deliver
    elsif self.state == 'attending'
      UserMailer.attend_course(self).deliver
    end
  end
end
