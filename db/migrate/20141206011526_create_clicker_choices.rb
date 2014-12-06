class CreateClickerChoices < ActiveRecord::Migration
  def change
    create_table :clicker_choices do |t|
      t.references :clicker, index: true
      t.references :user, index: true
      t.string :choice, null: false, default: 'text'
      t.string :message, null: false, default: ''

      t.timestamps null: false
    end
  end
end
