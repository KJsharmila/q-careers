class Users::DashboardController < Users::BaseController

  # GET /dashboard
  def index
    @event = Event.last
    # @event = nil
  end

  private

  def set_navs
    set_nav("user/dashboard")
    set_title("Dashboard | Q-Careers")
  end

end

