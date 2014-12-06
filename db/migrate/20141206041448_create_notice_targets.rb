class CreateNoticeTargets < ActiveRecord::Migration
  def change
    create_table :notice_targets do |t|
      t.references :notice, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
