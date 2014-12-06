class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :course, index: true
      t.references :user, index: true
      t.boolean :auto, null: false, default: false

      t.timestamps null: false
    end
  end
end
