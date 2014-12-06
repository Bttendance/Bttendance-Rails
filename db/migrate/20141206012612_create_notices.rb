class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.references :course, index: true
      t.references :user, index: true
      t.boolean :targeted, null: false, default: false
      t.string :message, null: false, default: ''

      t.timestamps null: false
    end
  end
end
