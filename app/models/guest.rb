class Guest < ActiveRecord::Base
  belongs_to :contact


  def name
    self.contact.name
  end
end
