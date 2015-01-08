class SchoolsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :school

  # Limit one instance of a (the same) school per user
  validates :school_id, uniqueness: { scope: :user_id }
  validates :identity, presence: true, if: :is_student?
  validates_inclusion_of :is_supervisor, :is_student, :is_administrator, :in => [true, false]

  # Set a primary key so we can use standard ActiveRecord methods
  self.primary_key = :user_id

  def is_student?
    self.is_student
  end
end
