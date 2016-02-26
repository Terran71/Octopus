class ImporterTool < ActiveRecord::Base
  class << self

    def find_contact_hash_from(current_user_id, import_source, import_hash )
      if import_source == "custom"
        custom_contact_hash(current_user_id, import_hash)
      elsif import_source == "google"
        google_contact_hash(current_user_id, import_hash)
      end

    end

    def find_address_hash_from(current_user_id, import_source, import_hash, address_kind)

      if import_source == "custom"
        us_state = USState.find_by_code(import_hash["state_code"])
        us_state_id = us_state.id unless us_state.blank?
        country_code = "US" #refactor
        country = Country.find_by_code(country_code) || Country.find_by_code("US")
        custom_address_hash(current_user_id, import_hash,address_kind, us_state, country)

      elsif import_source == "google"

        us_state = USState.find_by_code(import_hash["#{address_kind.titleize} State"])
        puts "#{us_state}" * 1000
        us_state_id = us_state.id unless us_state.blank?
        country_code = "US" #refactor
        country = Country.find_by_code(country_code) || Country.find_by_code("US")
        google_address_hash(current_user_id, import_hash, address_kind, us_state_id, country)
      # elsif address_kind == "work"
      # end
      elsif import_source == "apple"

      elsif import_source == "outlook"
      end
    end
  # First Name,Middle Name,Last Name,Title,Suffix,Initials,Web Page,Gender,Birthday,Anniversary,Location,Language,Internet Free Busy,Notes,
  #       E-mail Address,E-mail 2 Address,E-mail 3 Address,Primary 
  #       Phone,Home Phone,Home Phone 2,Mobile Phone,Pager,Home Fax,Home Address,Home Street,Home Street 2,Home Street 3,Home Address PO Box,Home City,Home State,Home Postal Code,Home Country,Spou

   def custom_contact_hash(current_user_id, import_hash)
      {
        first_name: import_hash["first_name"],
        last_name: import_hash["last_name"],
        email: import_hash["email"],
        primary_phone: import_hash["home_phone"] || import_hash["mobile_phone"],
        mobile_phone: import_hash["mobile_phone"],
        home_phone: import_hash["home_phone"],
        url: import_hash["url"],
        importer_user_id: current_user_id,
        editor_user_id: current_user_id,
        status: "approved"
      }
   end

   def google_contact_hash(current_user_id, import_hash)
         {
            first_name: import_hash["First Name"],
            middle_name: import_hash["Middle Name"],
            last_name: import_hash["Last Name"],
            prefix: import_hash["Title"],
            suffix: import_hash["Suffix"],
            # nickname: import_hash["Nickname"],
            url: import_hash["Web Page"],
            gender: import_hash["Gender"],
            birthday: import_hash["Birthday"],
            email: import_hash["E-mail"],
            note: import_hash["notes"],
            primary_phone: import_hash["Primary Phone"] || import_hash["Mobile Phone"],
            mobile_phone: import_hash["Mobile Phone"],
            home_phone: import_hash["Home Phone"],
            importer_user_id: current_user_id,
            editor_user_id: current_user_id,
            status: "approved"

          }
   end


    def google_address_hash(current_user_id, import_hash, address_kind, us_state_id, country)
         {
          title: address_kind.titleize,
          address_1: import_hash["#{address_kind.titleize} Street"],
          address_2:  import_hash["#{address_kind.titleize} Street 2"],
          city:  import_hash["#{address_kind.titleize} City"],
          us_state_id: us_state_id,
          postal_code:  import_hash["#{address_kind.titleize} Postal Code"],
          country_id: country.id,
          editor_user_id: current_user_id,
          importer_user_id: current_user_id
          }
    end

    def custom_address_hash(current_user_id, import_hash, address_kind, us_state_id, country)
         {
          title: address_kind.titleize,
          address_1: import_hash["address_1"],
          address_2:  import_hash["address_2"],
          city:  import_hash["city"],
          us_state_id: us_state_id,
          postal_code:  import_hash["postal_code"],
          country_id: country.id,
          editor_user_id: current_user_id,
          importer_user_id:current_user_id
          }
    end
  end
end
