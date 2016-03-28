class TimezoneTestJob < ActiveJob::Base
	# queue_as :mailers
  def self.perform
        users = User.all
        users.each do |user|
        # local_time = "08:55:00"
        # local_time = Time.now + 17.minutes

        d = Date.current
        t = Time.now + 7.minutes
        local_time = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec, t.zone)
        local_time = local_time.to_s
        zone = Time.zone
        if user.is_in_time_around(local_time) == true
          puts "#{user.is_in_time_around(local_time)} " * 100
          AdminMailer.timezone_test(user, local_time).deliver_later
          puts "sent time zone test"

        end



        # participants_in_active_projects

      #removeV1
      
   

    end


  end




end
