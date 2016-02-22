class Guest < ActiveRecord::Base
  belongs_to :contact


  def name
    contact.name
  end
end
