class UpdateCourseDefault < ActiveRecord::Migration
  def change
    change_column_default :courses, :open, true
  end
end
