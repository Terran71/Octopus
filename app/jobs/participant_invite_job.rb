class ParicipantInviteJob < ActiveJob::Base
	# queue_as :mailers
  def self.perform(participant_role)
    first_invite = participant_role.participant.received_email_logs.by_email_kind_category("invites")
    project = Project.find(participant_role.participant.project_id)
    if first_invite.blank?
       email_kind =  EmailKind.projecttype_roletype(project.category,  participant_role.type,  "invites", "first-invite")
        # email_kind = UserEmailKind.invites.where(project_type: project.category).where(role_type: participant_role.type).find_by_label("first-invite")|| EmailKind.find(1)
    else
       email_kind =  EmailKind.projecttype_roletype(project.category,  participant_role.type,  "invites", "reminder-invite")
    end

       if !participant_role.participant.contact_limit_reached(email_kind)
        ProjectMailer.invite(participant_role, email_kind).deliver
        puts "sent email kind #{email_kind.id}"
        AddEmailLogJob.perform(participant_role.participant, email_kind)

        #removeV1
        puts "logged email #{project.category} #{participant_role.type} #{email_kind.label}"
        puts "logged email #{email_kind.subject} "

        end
    end

            # email_kind = EmailKind.invites.where(project_type: "Meal Delivery").where(role_type: "HelperParticipantRole").find_by_label("first-invite")|| EmailKind.find(1)



     # if @project.is_meal_delivery? && @participant_role.participant.first_invite?
     #    if @participant_role.is_helper?
     #      # @subject = "You've been invited to help bring meals!"
     #    elsif @participant_role.is_recipient?
     #      # @subject = "#{@participant.invitor.name} has created Meal Deliveries for you!"
     #    elsif @participant_role.can_organize? && !@participant_role.is_recipient?
     #      # @subject = "You've been invited to help organize a Meal Deliveries!"
     #    else 
     #      # @subject ="Broken"
     #    end
     #  elsif @project.is_meal_delivery? &&  !@participant_role.participant.first_invite? && !@participant_role.participant.contact_limit_reached?
     #    if @participant_role.is_helper?
     #      # @subject = "REMINDER: RSVP to help bring meals!"
     #    elsif @participant_role.is_recipient?
     #      # @subject = "REMINDER: #{@participant.invitor.name} has created Meal Deliveries for you!"
     #    elsif @participant_role.can_organize? && !@participant_role.is_recipient?
     #      # @subject = "REMINDER: RSVP to  help organize a Meal Deliveries!"
     #    else 
     #      EmailKindCode.find(1)
     #      # @subject ="Broken"
     #    end
     #  end

 # ParicipantInviteJob.perform(participant_role)

end



