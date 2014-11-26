class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest
      t.string :name, null: false
      t.string :locale, null: false, default: 'en'

      t.timestamps null: false
    end

    add_index :users, :email
  end
end
