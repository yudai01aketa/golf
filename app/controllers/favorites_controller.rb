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
