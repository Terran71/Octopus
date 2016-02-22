class UploadCsvJob < ActiveJob::Base

  def self.perform(file, set_list_id, current_user_id, csv_source, auto_add_to_list)
    if csv_source == "custom"
      CSV.foreach(file.path, headers: true) do |row|
        import_hash = row.to_hash
        contact_hash = [import_hash["first_name"]], [import_hash["last_name"]]
        #create/update contact address
        contact = Contact.where(first_name: import_hash["first_name"], last_name: import_hash["last_name"] ).first
        if contact.present?
          contact.update_attributes(contact_hash)
        else
          contact = Contact.create(editor_user_id: current_user_id, user_id: current_user_id, first_name: import_hash["first_name"], last_name: import_hash["last_name"] )
          contact.save!
        end 

        #create address
        us_state = USState.find_by_code(import_hash["state_code"])
        us_state_id = us_state.id unless us_state.blank?
        country_code = "US" #refactor
        country = Country.find_by_code(country_code) || Country.find_by_code("US")

        address = Address.create(title: "Home Address", address_1:  import_hash["address_1"], address_2:  import_hash["address_2"],
                                   city:  import_hash["city"], us_state_id: us_state_id ,postal_code:  import_hash["zip"], country_id: country,
                                 )
        address.owner_type = "Contact"
        address.owner_id = contact.id
        address.save!
        # contact.add_contact_to_guest_list(set_list_id)
        # if auto_add_to_list == true
          AddContactToGuestListJob.perform(contact, set_list_id)
        # end
      end  
    elsif csv_source == "google"
    elsif csv_source == "outlook"
    elsif csv_source == "apple"
    else
    end       
        
  end


end
