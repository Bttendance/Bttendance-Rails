class CreateAttendancesUsers < ActiveRecord::Migration
  def change
    create_join_table :attendances, :users do |t|
      t.index :user_id
      t.index :attendance_id
      t.string :state, null: false

      t.timestamps null: false
    end
  end
end
