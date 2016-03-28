class EventResponseJob < ActiveJob::Base
	# queue_as :mailers
  def self.perform(event, current_user)
    @event  = event
    email_kind =  EmailKind.type_category_label(@event.project.category, "events", "event-response")
    notification_kind = NotificationKind.event_response.where( label: "#{@event.status}-event").first

    if @event.status == "accepted"
        @subject = "#{current_user.first_name} has approved your Visit"
    else
      @subject = "#{current_user.first_name} has requested that you reschedule your Visit"
    end  
    # @creator = Participant.find(@event.participant_id)
    # @project = Project.find(@creator.project_id)
    #sends to even scheduler
    
    ProjectMailer.event_response(@event, email_kind, @event.status, current_user, @subject).deliver_later
    puts "logged email #{event.project.category} #{email_kind.label}"

    AddEmailLogJob.perform(@event.participant, email_kind)
    AddNotificationJob.perform("UserNotification", notification_kind, current_user, @event.participant, event.id )

  end


end



