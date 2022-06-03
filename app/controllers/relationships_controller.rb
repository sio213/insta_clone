class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:followed_id])
    UserMailer.with(user_from: current_user, user_to: @user).follow.deliver_later if current_user.follow(@user)
  end

  def destroy
    relationship = Relationship.find(params[:id])
    @user = relationship.followed

    relationship.destroy!
  end
end
