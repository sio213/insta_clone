class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @posts = if current_user
               current_user.feed.includes(:user).page(params[:page]).order(created_at: :desc)
             else
               Post.all.includes(:user).page(params[:page]).order(created_at: :desc)
    end
    @users = User.recent(5)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, success: '投稿しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to root_path, success: '投稿を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to root_path, success: '投稿を削除しました'
  end

  def search
    @posts = @search_form.search.page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:body, images: [])
  end
end
