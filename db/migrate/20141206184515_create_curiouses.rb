class CreateCuriouses < ActiveRecord::Migration
  def change
    create_table :curiouses do |t|
      t.references :course, index: true
      t.references :user, index: true
      t.string :title, null: false
      t.string :message, null: false, default: ''

      t.timestamps null: false
    end
  end
end
