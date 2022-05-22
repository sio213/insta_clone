class Mypage::NotificationSettingsController < Mypage::BaseController
  def edit
    @notification_setting = User.find(current_user.id).notification_setting
  end

  def update
    @notification_setting = User.find(current_user.id).notification_setting

    if @notification_setting.update(notification_setting_params)
      redirect_to edit_mypage_notification_setting_path, success: '設定を更新しました'
    else
      flash.now[:danger] = '設定の更新に失敗しました'
      render :edit
    end
  end

  private

  def notification_setting_params
    params.require(:notification_setting).permit(:notification_on_comment, :notification_on_like, :notification_on_follow)
  end
end
