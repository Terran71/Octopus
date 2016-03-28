namespace :jt do




  task project_rsvps: :environment do
    ProjectRsvpJob.perform
    puts " project_rsvps"
  end
end