class UpdateSchoolsUsers < ActiveRecord::Migration
  def change
    change_column_null :schools_users, :identity, true
  end
end
