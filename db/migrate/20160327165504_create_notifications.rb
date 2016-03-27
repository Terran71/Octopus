class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :editor_user_id, index: true
      t.string :type,  null: false, default: ""
      t.integer :notification_kind, index: true
      t.boolean :viewed, default: false
      t.timestamps null: false
    end
  end
end
