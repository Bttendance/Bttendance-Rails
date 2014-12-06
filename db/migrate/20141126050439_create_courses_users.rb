class CreateCoursesUsers < ActiveRecord::Migration
  def change
    create_join_table :courses, :users do |t|
      t.index :user_id
      t.index :course_id
      t.string :state, null: false

      t.timestamps null: false
    end
  end
end
