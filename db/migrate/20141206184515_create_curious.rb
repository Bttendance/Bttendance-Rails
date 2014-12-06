class CreateCurious < ActiveRecord::Migration
  def change
    create_table :curious do |t|
      t.references :course, index: true
      t.references :user, index: true
      t.string :title, null: false, default: ''
      t.string :message, null: false, default: ''

      t.timestamps null: false
    end
  end
end
