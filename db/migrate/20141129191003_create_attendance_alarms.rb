class CreateAttendanceAlarms < ActiveRecord::Migration
  def change
    create_table :attendance_alarms do |t|
      t.references :course, index: true
      t.references :schedule, index: true
      t.references :user, index: true
      t.datetime :scheduled_for, null: false
      t.boolean :manual, null: false
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
