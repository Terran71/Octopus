class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true
      t.references :participant, index: true
      t.integer :notification_kind_id, index: true
      t.string :editor_user_id, index: true
      t.string :type,  null: false, default: ""
      t.integer :owner_id
      t.boolean :viewed, default: false
      t.datetime :viewed_at
      t.timestamps null: false
    end
  end
end
