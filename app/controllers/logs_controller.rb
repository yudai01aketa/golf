class LogsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :create

  def create
    @course = Course.find(params[:course_id])
    @log = @course.logs.build(content: params[:log][:content])
    @log.save
    flash[:success] = "コースログを追加しました！"
    # リスト一覧ページからラウンドログが作成された場合、そのコースをリストから削除
    List.find(params[:list_id]).destroy unless params[:list_id].nil?
    redirect_to course_path(@course)
  end

  def destroy
    @log = Log.find(params[:id])
    @course = @log.course
    if current_user == @course.user
      @log.destroy
      flash[:success] = "コースログを削除しました"
    end
    redirect_to course_url(@course)
  end

  private

  def correct_user
    # 現在のユーザーが対象のコースを保有しているかどうか確認
    course = current_user.courses.find_by(id: params[:course_id])
    redirect_to root_url if course.nil?
  end
end
