class Mypage::SettingsController < Mypage::BaseController
  def edit
    @setting = User.find(current_user.id).setting
  end

  def update
    @setting = User.find(current_user.id).setting

    if @setting.update(setting_params)
      redirect_to edit_mypage_setting_path, success: '設定を更新しました'
    else
      flash.now[:danger] = '設定の更新に失敗しました'
      render :edit
    end
  end

  private

  def setting_params
    params.require(:setting).permit(:notification_on_comment, :notification_on_like, :notification_on_follow)
  end
end
