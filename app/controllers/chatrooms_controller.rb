class ChatroomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @chatrooms = current_user.chatrooms.includes(:users, messages: :user).page(params[:page]).order(created_at: :desc)
  end

  def create
    users = User.where(id: params.dig(:chatroom, :user_ids)) + [current_user]
    @chatroom = Chatroom.chatroom_for_users(users)
    @messages = @chatroom.messages.order(created_at: :desc).limit(100).reverse
    redirect_to chatroom_path(@chatroom)
  end

  def show
    @chatroom = current_user.chatrooms.includes(:users).find(params[:id])
  end
end
