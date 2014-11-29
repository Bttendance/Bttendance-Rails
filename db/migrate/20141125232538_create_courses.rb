class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.references :school, index: true
      t.string :name, null: false
      t.string :instructor_name, null: false
      t.string :code, null: false
      t.string :information, null: false
      t.boolean :open, null: false
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
