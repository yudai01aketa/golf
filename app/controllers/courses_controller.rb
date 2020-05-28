class CoursesController < ApplicationController

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
