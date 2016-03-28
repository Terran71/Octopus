class UserNotification < Notification

  def name
    "Notification"
  end

  

   def link(category, amount)
    root_path
    # case category
    # when "project_info"
    #   case self.label
    #   when "edo"
    #     "Edo"
    #   end
    # when "project_rsvp" 
    #   case self.label
    #   when "edo"
    #     "Edo"
    #   end
    # when "event_info" #event_info
    #   case self.label
    #   when "new-meal-delivery-event"
    #     if amount == 1
    #      event = Event.find(self.owner_id)
    #      project_date_path(id: event.project_date_id, project_id: event.project_id)
    #     elsif amount >> 1
    #       "You have #{amount} New Events To Approve"
    #     end
    #   end
    # when "event_response"
    #   case self.label
    #   when "edo"
    #     "Edo"
    #   end
    # end
  end

  # def information

  #   "info here"
  # end
  # CATEGORIES = [:unset, :project_info, :project_rsvp, :event_info, :event_response]

  def information(category, amount, current_user)

    case category
    when "project_info"
      case self.label
      when "project_info"
        "#{self.editor.adjusted_name(current_user)} cancelled #{self.text}"
      end
    when "project_rsvp" 
      case self.label
      when "accepted-rsvp"
        if amount == 1
         participant = Participant.find(self.owner_id)
         "#{participant.adjusted_name(current_user)} will help with #{participant.project.short_title}"
        elsif amount >> 1
          "You have #{amount} Accpted RSVPs"
        end
      end
    when "project_rsvp" 
      case self.label
      when "declined-rsvp"
        if amount == 1
         participant = Participant.find(self.owner_id)
         "#{participant.adjusted_name(current_user)} has declined the invitatation to #{participant.project.short_title}"
        elsif amount >> 1
          "You have #{amount} Accpted RSVPs"
        end
      end
    when "event_info" #event_info
      case self.label
      when "new-meal-delivery-event"
        if amount == 1
         event = Event.find(self.owner_id)
         "#{event.participant.adjusted_name(current_user)} created an Event.  Click here to #{event.action_text(current_user)}"
        elsif amount >> 1
          "You have #{amount} New Events To Approve"
        end
      end
    when "event_response"
      case self.label
      when "reschedule-event"
         event = Event.find(self.owner_id)
         "#{self.editor.adjusted_name(current_user)} has requested that you reschedule your Event. Click here to reschedule."
      when "approved-event"
         event = Event.find(self.owner_id)
         "#{self.editor.adjusted_name(current_user)} has approved your Event date & time! Click here to view event."
      end
    end
  end

end
