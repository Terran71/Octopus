class BlogPostSocialSharingDraftWarningJob < ActiveJob::Base
	# queue_as :mailers
  def self.perform
    social_shares =  BlogPostLive.scheduled_this_week.by_social_share_status("draft")
    social_shares.count
    email_kind = EmailKind.admin_emails.warnings("BlogPostSocialSharingDraftWarningJob")
    mailing_list = AdminMailingList.by_email_kind_id(email_kind.id)
    notification_list = AdminNotificationList.by_label(email_kind_id)

    notification_list.each do |user|
     AdminNotification.create!(kind: 8, user_id: user.id, text: AdminNotification.kind_text(8, @social_shares.count))
    end

    mailing_list.each do |user|
        AdminMailer.warning(user, @social_shares, email_kind.id ).deliver_later
    end
      
  end   
end



