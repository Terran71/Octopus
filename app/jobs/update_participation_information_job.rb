class UpdateParticipationInformationJob < ActiveJob::Base

  def self.perform(user)
    participants = Participant.find_by_email(user.email)
    participants.each do |p|
    p.update_attributes!(user_id: user.id)
    notification = Notification.find_by_participant_id(p.id)
      notification.update_attributes!(user_id: user.id)
    end
  end   
end



