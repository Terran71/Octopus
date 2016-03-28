class RsvpNotificationJob < ActiveJob::Base

  def self.perform(participant)
    project = participant.project
    notification_kind = NotificationKind.project_rsvp.where(label: "#{participant.status}-rsvp").first
    project.project_organizers.each do |organizer|
      AddNotificationJob.perform("UserNotification", notification_kind, participant.user, organizer.participant, participant.id )
    end
  end   
end



