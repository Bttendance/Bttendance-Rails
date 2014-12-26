class AddFollowingToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :following, :boolean, null: false, default: true
  end
end
