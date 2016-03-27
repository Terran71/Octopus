class Notification < ActiveRecord::Base
  belongs_to :notification_kind
  belongs_to :editor, class_name: "User", foreign_key: "editor_user_id"



  scope :viewed, -> { where(viewed: true) }
  scope :unviewed, -> { where(viewed: false) }


  def self.types
    [
      AdminNotification,
      UserNotification,
      ].flatten
  end
end
