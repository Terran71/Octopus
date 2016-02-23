class FindHouseholdsJob < ActiveJob::Base

  def self.perform(current_user)
    contacts = current_user.contacts

    contacts.each do |contact|
      other_contacts = Contact.where.not(id: contact.id)
      other_contacts.each do |other|
        if contact.maybe_household_with?(other)
          AddFlagJob.perform("Contact", contact.id, "Potential Household
", "Are these two in the same household?" )
        else
          puts "#{contact.name} not in household with #{other_contact.name}"
        end
      end
    end 

  end

  


end
