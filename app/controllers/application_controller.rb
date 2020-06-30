class ApplicationController < ActionController::Base
  before_action :set_search
  protect_from_forgery with: :exception
  include SessionsHelper

 MAX_PAGE = 15
  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end

  # フィードから検索条件に該当する料理を検索
  def set_search
    if logged_in?
      @search_word = params[:q][:name_cont] if params[:q]
      @q = current_user.feed.paginate(page: params[:page], per_page: MAX_PAGE).ransack(params[:q])
      @courses = @q.result(distinct: true)
    end
  end
end
