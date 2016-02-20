class AddEmailLogJob < ActiveJob::Base

  def self.perform(recipient, email_kind)
     EmailLog.create!(email_kind_id: email_kind.id, receiver_participant_id: recipient.id)
  end   
end



