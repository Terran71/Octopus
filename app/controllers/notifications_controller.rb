class NotificationsController < DashboardController
  before_action :store_location
  before_action :authenticate_user!
  before_action :set_nested_project, only: []
  before_action :set_current_user_participation, only: []

  def index
    @notifications = UserNotification.includes(:notification_kind)
    @notifications.unviewed.each do |notification|
      notification.update_attributes!(viewed: true, viewed_at: Time.now)
    end
  end
end
