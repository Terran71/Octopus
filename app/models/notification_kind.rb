class NotificationKind < ActiveRecord::Base
  has_many :notifications

  ALERT_LEVELS = [:unknown, :success, :warning, :danger, :info]
  enum alert_level: ALERT_LEVELS

  CATEGORIES = [:unset, :project_info, :project_rsvp, :event_info, :event_response]
  enum category: CATEGORIES


  scope :project_info, -> { where(category: 1) }
  scope :project_info, -> { where(category: 2) }
  scope :event_info, -> { where(category: 3) }
  scope :event_response, -> { where(category: 4) }

end
