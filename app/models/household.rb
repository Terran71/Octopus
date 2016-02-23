class Household < ActiveRecord::Base
  has_many :addresses, class_name: "Address", foreign_type: "Household", foreign_key: 'owner_id', dependent: :destroy


  def primary_address
      self.addresses.primary.first
  end

    def default_address
      if     self.addresses.primary.first.present?
            self.addresses.primary.first
      else
            self.addresses.first
      end
    end




    def default_address_id
      if    self.default_address.present?
            self.default_address.id
      else
        nil
      end
    end

    def default_name(contact_array)
      first_contact = contact_array.first
      if contact_array.count == 2
        second_contact = contact_array.second
        "#{first_contact.name} & #{second_contact.name}" 
      elsif contact_array.count >> 2
         "The #{first_contact.last_name} Family" 
      elsif contact_array.count == 1
       " #{first_contact.name}" 
      end
    end

    def find_new_default_address_id(contact_array)
      @contacts = contact_array
       if  @contacts.first.default_address.present?
        @contacts.first.default_address.id
      elsif @contacts.second.default_address.present?
         @contacts.second.default_address.id
      else
         nil
      end
    end

end
