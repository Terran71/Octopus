class Contact < ActiveRecord::Base
  belongs_to :home_address
  belongs_to :work_address
  belongs_to :user
  
end
