class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :us_state, index: true
      t.references :country, index: true
      t.references :project, index: true
      t.references :user
      t.integer :kind, default: 1, index: true
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :postal_code
      t.string :venue #
      t.string :title #
      t.boolean :primary, default: true

      t.timestamps null: false
    end
  end
end
