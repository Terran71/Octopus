class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :editor_user_id
      t.references :user, index: true
      t.string :prefix
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :work_phone
      t.string :home_phone
      t.string :mobile_phone
      t.integer :home_address_id
      t.integer :work_address_id
      t.integer :uploded_id
      t.timestamps null: false
    end
  end
end
