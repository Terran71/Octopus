class UserNotification < Notification

  def name
    "Notification"
  end

  def link
    "root_path"
  end

  # def information

  #   "info here"
  # end
  # CATEGORIES = [:unset, :project_info, :project_rsvp, :event_info, :event_response]

  def information(category, amount)

    case category
    when "project_info"
      case self.label
      when "edo"
        "Edo"
      end
    when "project_rsvp" 
      case self.label
      when "edo"
        "Edo"
      end
    when "event_info" #event_info
      case self.label
      when "new-meal-delivery-event"
        if amount == 1
         event = Event.find(self.owner_id)
         # @link = event_path(event_id: event.id, project_date_id: event.project_date.id)
         "#{event.participant.name} has created an Event.  Click here to approve/reschedule"
        elsif amount >> 1
          "You have #{amount} New Events To Approve"
        end
      end
    when "event_response"
      case self.label
      when "edo"
        "Edo"
      end
    end
  end

end
