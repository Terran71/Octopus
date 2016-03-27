class AddNotificationJob < ActiveJob::Base

  def self.perform(type, notification_kind, editor, user)
     notification_type = type.constantize
     notification_type.create!(notification_kind_id: notification_kind.id, 
                               editor_user_id: editor.id, user_id: user.id)
  end   
end



