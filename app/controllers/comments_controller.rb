class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)

    if comment.save
      redirect_to post_path(params[:post_id]), success: 'コメントを投稿しました'
    else
      redirect_to post_path(params[:post_id]), alert: comment.errors.full_messages.first
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.find(params[:id])
  end

  def update
    comment = current_user.comments.find(params[:id])

    if comment.update(update_comment_params)
      redirect_to post_path(params[:post_id]), success: 'コメントを更新しました'
    else
      redirect_to post_path(params[:post_id]), alert: comment.errors.full_messages.first
    end
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.destroy!

    redirect_to post_path(params[:post_id]), success: 'コメントを削除しました'
  end
end

private

def comment_params
  params.require(:comment).permit(:body).merge(post_id: params[:post_id])
end

def update_comment_params
  params.require(:comment).permit(:body)
end
