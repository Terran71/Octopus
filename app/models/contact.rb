class Contact < ActiveRecord::Base
  # belongs_to :home_address
  # belongs_to :work_address
  belongs_to :user
  has_many :guests
  has_many :list_recipients, through: :guests
  has_many :addresses, class_name: "Address", foreign_type: "Contact", foreign_key: 'owner_id', dependent: :destroy


def self.import(file, set_list_id)
  
  # header = spreadsheet.row(1)
  # (2..spreadsheet.last_row).each do |i|
  #   row = Hash[[header, spreadsheet.row(i)].transpose]
  CSV.foreach(file.path, headers: true) do |row|
      contact_hash = row.to_hash
      # row.strip.split(",(?=([^\"]*\"[^\"]*\")*[^\"]*$)");
      c = Contact.new(first_name: ["contact_hash"]["first_name"])
      c.save!
      # c.add_contact_to_guest_list(set_list_id)
    end

end


def self.import(file, set_list_id, current_user_id)
    CSV.foreach(file.path, headers: true) do |row|
      import_hash = row.to_hash
      puts "#{import_hash["last_name"]}" * 50
      puts "#{import_hash["address_1"]}" * 50

      # address_hash = {}
      # address = Address.new
      # contact_hash.each { |k, v| address_hash[k] = contact_hash.delete(k) if address.respond_to?(k) }    

      contact = Contact.where(first_name: "fuck dis", last_name: import_hash["last_name"] ).first
      if contact.present?
        contact.first.update_attributes(contact_hash)
      else
        contact = Contact.create(user_id: current_user_id, first_name: import_hash["first_name"], last_name: import_hash["last_name"] )
        contact.save!
      end
        address = Address.create(address_1:  import_hash["address_1"], address_2:  import_hash["address_2"],
                                 city:  import_hash["city"], postal_code:  import_hash["zip"],
          )

        # us_state_code = USState.where(code: import_hash["state_code"])
        # us_state_codee_id = us_state_code.id || 1

        # country_code = Country.where(code: import_hash["country"])
        # country_code_id = country_code.id || 1
        # address.update_attributes(us_state_code_id: state_code_id, country_code_id: country_code_id  )
        address.owner_type = "Contact"
        address.owner_id = contact.id
        address.save!
        contact.add_contact_to_guest_list(set_list_id)
    end
  end

def add_contact_to_guest_list(list_id)
  guest = Guest.create(contact_id: self.id)
  guest.save!
  ListRecipient.create!(list_id: list_id, guest_id: guest.id)
end

def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when ".csv" then Csv.new(file.path, nil, :ignore)
  when ".xls" then Excel.new(file.path, nil, :ignore)
  when ".xlsx" then Excelx.new(file.path, nil, :ignore)
  else raise "Unknown file type: #{file.original_filename}"
  end
end
  
end
