class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true
      t.references :user, index: true
      t.string :message, null: false

      t.timestamps null: false
    end
  end
end
