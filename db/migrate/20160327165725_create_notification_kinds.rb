class CreateNotificationKinds < ActiveRecord::Migration
  def change
    create_table :notification_kinds do |t|
      t.string :owner_type
      t.integer :alert_level
      t.integer :category
      t.string :label
      t.string :text
      t.timestamps null: false
    end
  end
end
