class Household < ActiveRecord::Base
  has_many :addresses, class_name: "Address", foreign_type: "Household", foreign_key: 'owner_id', dependent: :destroy
  has_many :contact_households
  has_many :contacts, through: :contact_households

  enum status: [:unknown ,  :pending, :rejected, :approved]
  scope :pending, -> { where(status: 1) }




  #     self.addresses.primary.first
  # end

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

    def default_name(contact_array, *)
      formality = formality || 22
      first_contact = contact_array.first
      if contact_array.count == 2
        contact_couple_name(formality,  contact_array) 
      elsif contact_array.count >> 2
        contact_family_name(formality,  contact_array) 
         "The #{first_contact.last_name} Family" 
      elsif contact_array.count == 1
        contact_single_name(formality,  contact_array) 
       " #{first_contact.name}" 
      end
    end

    def contact_couple_name(formality,  contact_array)
      first_contact = contact_array.first
      second_contact = contact_array.first
      if formality == 1
        if first_contact.shares_last_name?(second_contact)

        else

        end
      elsif formality ==2
        if first_contact.shares_last_name?(second_contact)

        else

        end
      elsif formality == 3
        "#{first_contact.name_with_prefix} & #{second_contact.name_with_prefix}" 

      else
        " #{first_contact.name} & #{second_contact.name}" 
      end
    end

    def contact_family_name(formality, contact_array)
      if formality == 1
        "The Griswold Family"
      else
        "The Griswolds"
      end
    end

    def find_new_default_address_id(contact_array)
      @contacts = contact_array
      if default_address.present?
        default_address.id
      elsif  @contacts.first.default_address.present?
        @contacts.first.default_address.id
      elsif @contacts.second.default_address.present?
         @contacts.second.default_address.id
      else
         nil
      end
    end

end
