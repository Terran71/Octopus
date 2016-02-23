class FindHouseholdsJob < ActiveJob::Base

  def self.perform(current_user)
    @contacts = current_user.imported_contacts

    @contacts.each do |contact|
      other_contacts = Contact.where.not(id: contact.id)

      other_contacts.each do |other_contact|
        puts "checking #{contact.name} and #{other_contact.name}"
        if contact.maybe_household_with?(other_contact)
          AddHouseholdJob.perform(current_user.id, @contacts, "unconfirmed")
          
#           AddFlagJob.perform("Contact", contact.id, "Potential Household
# ", "Are these two in the same household?", "Contact", other_contact.id )
        else
          puts "#{contact.name} not in household with #{other_contact.name}"
        end
      end
    end 

  end

  

end
