class Mypage::ActivitiesController < Mypage::BaseController
  def index
    @activities = current_user.activities.order(created_at: :desc).page(params[:page]).per(10)
  end
end
