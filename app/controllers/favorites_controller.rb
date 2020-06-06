class FavoritesController < ApplicationController
  before_action :logged_in_user

  def index
    @favorites = current_user.favorites
  end

  def create
    @course = Course.find(params[:course_id])
    @user = @course.user
    current_user.favorite(@course)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
    # お気に入り登録は通知種別1
    if @user != current_user
      @user.notifications.create(course_id: @course.id, variety: 1,
                                 from_user_id: current_user.id)
      @user.update_attribute(:notification, true)
    end
  end

  def destroy
    @course = Course.find(params[:course_id])
    current_user.favorites.find_by(course_id: @course.id).destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
