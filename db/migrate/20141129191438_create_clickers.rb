class CreateClickers < ActiveRecord::Migration
  def change
    create_table :clickers do |t|
      t.references :course, index: true
      t.references :user, index: true
      t.string :type, null: false, default: 'mult4'
      t.string :message, null: false, default: ''
      t.boolean :saved, null: false, default: false
      t.integer :time_length, null: false, default: 45
      t.boolean :cheating, null: false, default: true
      t.string :privacy, null: false, default: 'professor'

      t.timestamps null: false
    end
  end
end
