class CoursesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update]

  def index
    @log = Log.new
  end

  def new
    @course = Course.new
  end

  def search
    @courses = RakutenWebService::Gora::Course.search(keyword: params[:keyword], hits: 10)
  end

  def show
    @course = Course.find(params[:id])
    @courses = RakutenWebService::Gora::Course.search(keyword: @course.name).first
    @comment = Comment.new
    @log = Log.new
    @hash = Gmaps4rails.build_markers(@place) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow place.name
    end
  end

  def create
    @course = current_user.courses.build(course_params)
    if @course.save
      flash[:success] = "コースが登録されました！"
      Log.create(course_id: @course.id, content: @course.memo)
      redirect_to root_url
    else
      render 'courses/new'
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(course_params)
      flash[:success] = "コース情報が更新されました！"
      redirect_to @course
    else
      render 'edit'
    end
  end

  def destroy
    @course = Course.find(params[:id])
    if current_user.admin? || current_user?(@course.user)
      @course.destroy
      flash[:success] = "コースが削除されました"
      redirect_to request.referrer == user_url(@course.user) ? user_url(@course.user) : root_url
    else
      flash[:danger] = "他人のコースは削除できません"
      redirect_to root_url
    end
  end

  private

  def correct_user
    # 現在のユーザーが更新対象の料理を保有しているかどうか確認
    @course = current_user.courses.find_by(id: params[:id])
    redirect_to root_url if @course.nil?
  end

  def course_params
    params.require(:course).permit(
      :name, :discription, :tips, :address, :latitude, :longitude,
      :reference, :score, :recommend, :memo, :picture
    )
  end
end
