class ImportContactsJob < ActiveJob::Base

  def self.perform(file, set_list_id, current_user_id, import_source, auto_add_to_list, file_type)
    Contact.destroy_all
    Address.destroy_all
    Guest.destroy_all
    if import_source == "custom"
      # if file_type == "CSV"
      #   CSV.foreach(file.path, headers: true) do |row|
      # elsif file_type == "XLS"
      #   XLS.foreach(file.path, headers: true) do |row|
      # elsif  file_type == "XLSX"
      #   XLSX.foreach(file.path, headers: true) do |row|
      # end
      CSV.foreach(file.path, headers: true) do |row|
      # "#{file_type}".foreach(file.path, headers: true) do |row|

        import_hash = row.to_hash
        # contact_hash = [import_hash["first_name"]], [import_hash["last_name"]]
        # contact_hash = {
        #   first_name: import_hash["first_name"],
        #   last_name: import_hash["last_name"],
        #   email: import_hash["email"],
        #   primary_phone: import_hash["home_phone"] || import_hash["mobile_phone"],
        #   mobile_phone: import_hash["mobile_phone"],
        #   home_phone: import_hash["home_phone"],
        #   url: import_hash["url"]
        # }

        contact_hash = ImporterTool.find_contact_hash_from(import_source, import_hash)

        #create/update contact address
        contact = Contact.where(first_name: import_hash["first_name"], last_name: import_hash["last_name"], email: import_hash["email"]).first
        if contact.present?
          contact.update_attributes(contact_hash)
          # Flag.create(category: 'contact_changed', owner_id: contact.id, owner_type: "Contact")
        else
          # contact = Contact.create(editor_user_id: current_user_id, user_id: current_user_id, first_name: import_hash["first_name"], last_name: import_hash["last_name"] )
          contact = Contact.create!(contact_hash)
          # contact.save!
        end 

        #create address
        # us_state = USState.find_by_code(import_hash["state_code"])
        # us_state_id = us_state.id unless us_state.blank?
        # country_code = "US" #refactor
        # country = Country.find_by_code(country_code) || Country.find_by_code("US")
        home_address_hash = ImporterTool.find_address_hash_from(import_source, import_hash, "home")
        # home_address_hash = {
        #   title: "home",
        #   address_1: import_hash["address_1"],
        #   address_2:  import_hash["address_2"],
        #   city:  import_hash["city"],
        #   us_state_id: us_state_id,
        #   postal_code:  import_hash["postal_code"],
        #   country_id: country.id,
        # }
        home_address = Address.create!(home_address_hash)

        # address = Address.create(title: "Home Address", address_1:  import_hash["address_1"], address_2:  import_hash["address_2"],
        #                            city:  import_hash["city"], us_state_id: us_state_id, postal_code:  import_hash["postal_code"], country_id: country,
        #                          )
        home_address.owner_type = "Contact"
        home_address.owner_id = contact.id
        home_address.save!
        # contact.add_contact_to_guest_list(set_list_id)
        # if auto_add_to_list == true
          AddContactToGuestListJob.perform(contact, set_list_id)
        # end
      end  
    elsif import_source == "google"
    elsif import_source == "outlook"
    elsif import_source == "apple"
    else
    end       
        
  end

  


end
