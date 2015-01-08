class UpdateSchoolUser < ActiveRecord::Migration
  def change
    remove_column :schools_users, :state, :string
    add_column :schools_users, :is_supervisor, :boolean, null: false, default: false
    add_column :schools_users, :is_student, :boolean, null: false, default: false
    add_column :schools_users, :is_administrator, :boolean, null: false, default: false
  end
end
