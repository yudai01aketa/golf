class ListsController < ApplicationController
  before_action :logged_in_user

  def index
    @lists = current_user.lists
    @log = Log.new
  end

  def create
    @course = Course.find(params[:course_id])
    @user = @course.user
    current_user.list(@course)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    list = List.find(params[:list_id])
    @course = list.course
    list.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
