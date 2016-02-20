class CreateSocialAccounts < ActiveRecord::Migration
  def change
    create_table :social_accounts do |t|
      t.references :user
      t.integer :platform
      t.string :name
      t.string :url
      t.integer :editor_user_id, default: 1
      t.string :handle, index: true
      t.string :api_code
      t.string :login
      t.string :encrypted_password, null: false, default: ""
      t.boolean :internal, default: false

      t.timestamps null: false
    end
  end
end
