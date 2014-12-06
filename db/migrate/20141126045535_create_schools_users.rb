class CreateSchoolsUsers < ActiveRecord::Migration
  def change
    create_join_table :schools, :users do |t|
      t.index :user_id
      t.index :school_id
      t.string :identity, null: false
      t.string :state, null: false

      t.timestamps null: false
    end
  end
end
