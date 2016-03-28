class TimezoneTestJob < ActiveJob::Base
	# queue_as :mailers
  def self.perform
        users = User.all
        users.each do |user|
        local_time = "08:55:00"
        if user.is_in_time_around(local_time)
          AdminMailer.timezone_test(user, local_time).deliver_later
        end



        # participants_in_active_projects

      #removeV1
        puts "sent time zone test"
      
   

    end


  end




end
