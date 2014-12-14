class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.references :user, index: true
      t.boolean :clicker, null: false, default: true
      t.boolean :attendance, null: false, default: true
      t.boolean :notice, null: false, default: true
      t.boolean :curious, null: false, default: true

      t.timestamps null: false
    end
  end
end
