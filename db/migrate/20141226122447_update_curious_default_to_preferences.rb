class UpdateCuriousDefaultToPreferences < ActiveRecord::Migration
  def change
    change_column_default :preferences, :curious, false
  end
end
