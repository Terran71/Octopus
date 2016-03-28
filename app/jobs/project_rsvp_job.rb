class ProjectRsvpJob < ActiveJob::Base
	# queue_as :mailers

  def self.perform
    email_type = "UserEmailKind"
    email_category = "organizers"
    email_label = "project-rsvp"
    email_kind =  EmailKind.type_category_label(email_type, email_category, email_label)

    last_email = EmailLog.where(email_kind_id: email_kind ).last 
    if last_email.present?
      updated_after_datetime = last_email.created_at 
    else
      updated_after_datetime = Time.zone.now - 1.week 
    end

    @participant_roles = ParticipantRole.includes(:participant).firm_answers.updated_after(updated_after_datetime)
    @projects = Project.all 

    @projects.each do |project|
      if project.has_rsvp_since?(updated_after_datetime)
        puts "#{project.new_rsvps_since(updated_after_datetime).accepted.count} accepted"
        puts "#{project.new_rsvps_since(updated_after_datetime).declined.count} declined"
        subject = "#{project.new_rsvps_since(updated_after_datetime).count} new RSVPs for #{project.short_title}"
        project.project_organizers.each do |organzer|
          ProjectMailer.project_rsvp_roundup(organzer.participant, email_kind, subject, updated_after_datetime).deliver
        end
        # project.new_rsvps_since(datetime).each do |participant_role|
      end
    end
  end
end

  # def self.perform
  #   email_type = "UserEmailKind"
  #   email_category = "organizers"
  #   email_label = "project-rsvp"
  #   email_kind =  EmailKind.type_category_label(email_type, email_category, email_label)

  #   last_email = EmailLog.where(email_kind_id: email_kind ).last
  #   # email_kind =  EmailKind.projecttype(event.project.category, "events", "response-#{response}")
  #   updated_after_date = Date.today - 1.day
  #   projects = Project.all
  #   participant_roles = ParticipantRole.firm_answers.updated_after(updated_after_date)

  #   projects.each do |project|
  #     @new_rsvps = participant_roles.where(project_id: project.id) unless participant_roles.blank?
  #     if @new_rsvps.present?
  #       project.project_organizers.each do |organizer|
  #       participant = project.participants.first #refactor
  #       ProjectMailer.project_rsvps(project,  email_kind, participant, updated_after_date.to_s).deliver_later
  #       puts "logged email #{project} #{email_kind.label}"

  #       email_recipient = organizer
  #       AddEmailLogJob.perform(email_recipient, email_kind)
  #     end

  #    end
    


  #  end
  # end





      # new_rsvps = participant_roles.where("updated_at >= ?", Date.today) unless participant_roles.blank?
