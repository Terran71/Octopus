class NotificationKind < ActiveRecord::Base
  has_many :notifications

  ALERT_LEVELS = [:success, :warning, :danger, :info]
  enum alert_level: ALERT_LEVELS

  CATEGORIES = [:project_info, :project_rsvp, :event_info, :event_rsvp]
  enum category: CATEGORIES
end
