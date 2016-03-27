class NotificationsController < DashboardController
  before_action :store_location
  before_action :authenticate_user!

  def index
    @notifications = UserNotification.includes(:notification_kind)
    @notifications.update_attributes!(viewed: true, viewed_at: Time.now)
  end
end
