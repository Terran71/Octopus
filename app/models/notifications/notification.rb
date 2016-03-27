class Notification < ActiveRecord::Base
  belongs_to :notification_kind
  belongs_to :editor, class_name: "User", foreign_key: "editor_user_id"



  scope :viewed, -> { where(viewed: true) }
  scope :unviewed, -> { where(viewed: false) }
  scope :unviewed_before_timenow, -> { where("viewed_at >= ?", Time.now - 1.minute) }


  def self.types
    [
      AdminNotification,
      UserNotification,
      ].flatten
  end
end
