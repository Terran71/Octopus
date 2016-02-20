class AddNewUserDefaultsJob < ActiveJob::Base

  def self.perform(user)

    Profile.create!(user_id: user.id, originally_created_at: user.created_at)

    user_email_kinds = EmailKind.user_email 
    user_email_kinds.each do |ek|
      EmailList.create!(user_id: user.id, email_kind_id: ek.id)
    end

  end   
end



