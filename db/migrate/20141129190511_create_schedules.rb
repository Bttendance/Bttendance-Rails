class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :course, index: true
      t.string :day_of_week, null: false
      t.string :time, null: false
      t.string :timezone, null: false

      t.timestamps
    end
  end
end
