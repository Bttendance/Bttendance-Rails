class CreateUserSchools < ActiveRecord::Migration
  def change
    create_join_table :users, :schools do |t|
      t.index :user_id
      t.index :school_id
    end
  end
end
