class Notification < ActiveRecord::Base
  belongs_to :notification_kind
  belongs_to :editor, class_name: "User", foreign_key: "editor_user_id"



  scope :viewed, -> { where(viewed: true) }
  scope :unviewed, -> { where(viewed: false) }
  scope :unviewed_before_timenow, -> { where("viewed_at >= ?", Time.now - 2.minutes) }
  scope :viewed_before_timenow, -> { where.not("viewed_at >= ?", Time.now - 2.minutes) }


  def self.types
    [
      AdminNotification,
      UserNotification,
      ].flatten
  end

  def link
    "root_path"
  end

  def information
    "info here"
  end

  def category
    notification_kind.category
  end

  def label
    notification_kind.label
  end

end
