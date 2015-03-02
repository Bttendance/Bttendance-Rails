class AddDeviseColumnsToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      # Database authenticatable
      t.change :email, :string, null: false, default: ''
      t.string :encrypted_password, null: false, default: '', limit: 128

      t.remove :password_digest

      # Omniauthable
      t.string :provider
      t.string :uid

      # Lockable
      t.integer :failed_attempts, null: false, default: 0
      t.string :unlock_token
      t.datetime :locked_at

      # Recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      # Rememberable
      t.datetime :remember_created_at

      # Trackable
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet :current_sign_in_ip
      t.inet :last_sign_in_ip
    end
  end
end
