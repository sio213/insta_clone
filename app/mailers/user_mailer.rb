class UserMailer < ApplicationMailer
  before_action :set_mailer_info

  def like_post
    return unless @user_to.notification_setting.notification_on_like?

    @post = params[:post]
    mail(to: @user_to.email, subject: "#{@user_from.username}があなたの投稿にいいねしました")
  end

  def comment_post
    return unless @user_to.notification_setting.notification_on_comment?

    @comment = params[:comment]
    mail(to: @user_to.email, subject: "#{@user_from.username}があなたの投稿にコメントしました")
  end

  def follow
    return unless @user_to.notification_setting.notification_on_follow?

    mail(to: @user_to.email, subject: "#{@user_from.username}があなたをフォローしました")
  end

  private

  def set_mailer_info
    @user_from = params[:user_from]
    @user_to = params[:user_to]
  end
end