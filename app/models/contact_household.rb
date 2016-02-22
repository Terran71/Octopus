class ContactHousehold < ActiveRecord::Base
  belongs_to :contact
  belongs_to :household

  belongs_to :default_address
  belongs_to :secondary_address
end
