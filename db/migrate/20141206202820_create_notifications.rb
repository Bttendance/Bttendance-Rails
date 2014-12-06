class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :notifiable, polymorphic: true
      t.references :user, index: true
      t.references :course, index: true
      t.boolean :seen, null: false, default: false

      t.timestamps null: false
    end
  end
end
