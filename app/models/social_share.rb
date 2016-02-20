class SocialShare < ActiveRecord::Base
  belongs_to :social_account
  belongs_to :blog_post

  STATUSES = [:draft, :scheduled, :shared]

  enum status: STATUSES

  scope :internal, -> { where(internal: true) }
  scope :scheduled, -> { where(status: 1) }
  scope :scheduled_tomorrow, -> { where(scheduled_datetime: Date.today + 1.day )}
  scope :scheduled_today, -> { where(scheduled_datetime: Date.today  )}
  scope :scheduled_this_week, -> { where("scheduled_datetime >= ?", Date.today + 1.day).where("scheduled_datetime <= ?", Date.today + 8.days)}
  scope :past, -> { where(status: 3).where("scheduled_datetime <= ?", Date.today)}


  #add sharing authentications

  def is_scheduled_for(timeline)
    if timeline == "tomorrow"
      self.scheduled_tomorrow.present?
    elsif timeline == "today"
      self.scheduled_today.present?
    elsif timeline == "this_week"
      self.scheduled_this_week.present?
    end
  end

  def icon
    if self.social_account.facebook?
      "fa-facebook-officia"
    elsif self.social_account.twitter?
      "fa-twitter"
    end
  end


end
