class Household < ActiveRecord::Base
  has_many :addresses, class_name: "Address", foreign_type: "Household", foreign_key: 'owner_id', dependent: :destroy
end
