class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @course = Course.find(params[:course_id])
    @user = @course.user
    @comment = @course.comments.build(
      user_id: current_user.id, content: params[:comment][:content]
    )
    if !@course.nil? && @comment.save
      flash[:success] = "コメントを追加しました！"
      # 自分以外のユーザーからコメントがあったときのみ通知を作成
      # コメントは通知種別2
      if @user != current_user
        @user.notifications.create(course_id: @course.id, variety: 2,
                                   from_user_id: current_user.id,
                                   content: @comment.content)
        @user.update_attribute(:notification, true)
      end
    else
      flash[:danger] = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    @comment = Comment.find(params[:id])
    @course = @comment.course
    if current_user.id == @comment.user_id
      @comment.destroy
      flash[:success] = "コメントを削除しました"
    end
    redirect_to course_url(@course)
  end
end
