class EventChangesJob < ActiveJob::Base
	# queue_as :mailers
  def self.perform
    last_update_time = Time.zone.now - 70.minutes
    @events = Event.includes(:attendees).updated_after(last_update_time)

    @events.each do |event|
      event.attendees.each do |attendee|
        
      end
    end
  end


end



