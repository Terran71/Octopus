class AddNotificationJob < ActiveJob::Base

  def self.perform(type, notification_kind, editor, participant, owner_id)
     notification_type = type.constantize
     user = participant.user
     owner_id = owner_id if owner_id.present?
     if user.present?
      puts "user exists"
      notification_type.create!(notification_kind_id: notification_kind.id, owner_id: owner_id,  
                               editor_user_id: editor.id, user_id: user.id, participant_id: participant.id)
     elsif  participant.present?
      puts "participant exists"
      notification_type.create!(notification_kind_id: notification_kind.id, owner_id: owner_id,  
                               editor_user_id: editor.id, participant_id: participant.id)
     end
  end   
end



