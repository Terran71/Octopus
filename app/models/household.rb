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

end
