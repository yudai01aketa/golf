class CoursesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update]

  def new
    @course = Course.new
  end

  def show
    @course = Course.find(params[:id])
  end

  def create
    @course = current_user.courses.build(course_params)
    if @course.save
      flash[:success] = "コースが登録されました！"
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
      :name, :discription, :tips,
      :reference, :score, :recommend, :memo, :picture
    )
  end

  def autocomplete_search
    places = {}
    if params[:term]
      courses = RakutenWebService::Gora::Course.search(keyword: params[:term].to_s)
      courses.each do |course|
        golf_course_id = course['golfCourseId']
        golf_course_abbr = course['golfCourseAbbr']
        golf_course_abbr = golf_course_abbr.to_s + '[' + golf_course_id.to_s + ']'
        places[golf_course_id] = golf_course_abbr
      end
    end
    render json: places.to_json
  end

  def golf_course_info
    course_info = RakutenWebService::Gora::CourseDetail.search(golfCourseId: params[:course_id])
    unless course_info.nil?
      course_info_first = course_info.first
      address = course_info_first['address']
      golf_course_image_url = course_info_first['golfCourseImageUrl1']
      respond_to do |format|
        format.json do
          render json: { address: address,
                         golf_course_image_url: golf_course_image_url }, status: :ok
        end
      end
    end
  end
end
