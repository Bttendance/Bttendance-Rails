class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.references :user, index: true
      t.string :platform, null: false
      t.string :uuid
      t.string :mac_address
      t.string :notification_key

      t.timestamps null: false
    end
  end
end
