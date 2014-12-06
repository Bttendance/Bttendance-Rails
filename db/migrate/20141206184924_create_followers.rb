class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.references :followable, polymorphic: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
