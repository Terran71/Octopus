class SplitHouseholdsJob < ActiveJob::Base

  def self.perform(current_user_id, splitable_contact)
    household = Household.create!(name: splitable_contact.name, default_address_id: splitable_contact.default_address_id,
                                         status: "pending_split", importer_user_id: current_user_id,
                                         editor_user_id: current_user_id)
    splitable_contact_hash = splitable_contact.attributes
    first_contact = Contact.new(splitable_contact_hash)
    first_contact.id = nil 
    first_contact.status = "pending_discard"
    first_contact.save
    second_contact = Contact.new
    second_contact.first_name = splitable_contact.find_first_name("second")
    second_contact.last_name = splitable_contact.last_name
    second_contact.status = "pending_new"
    second_contact.update_attributes(editor_user_id: splitable_contact.editor_user_id, importer_user_id: splitable_contact.importer_user_id)
    second_contact.save

    splitable_contact.update_attributes(status:  "pending_edit")
    splitable_contact.first_name = splitable_contact.find_first_name("first")
    splitable_contact.save

    ContactHousehold.create!(contact_id: first_contact.id, household_id: household.id)
    ContactHousehold.create!(contact_id: second_contact.id, household_id: household.id)
    ContactHousehold.create!(contact_id: splitable_contact.id, household_id: household.id)

  end
  

end
