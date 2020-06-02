require "rails_helper"

RSpec.describe "コース編集", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:course) { create(:course, user: user) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      get edit_course_path(course)
      login_for_request(user)
      expect(response).to redirect_to edit_course_url(course)
      patch course_path(course), params: {
        course: {
          name: "大神戸ゴルフ場",
          description: "四季折々の風景が楽しめるコースとなっております",
          tips: "バンカーが多くて難しい場面もありますが、OBが出にくいコースとなっています",
          reference: "https://cookpad.com/recipe/2798655",
          score: 100,
          recommend: 5
        }
      }
      redirect_to course
      follow_redirect!
      expect(response).to render_template('courses/show')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      # 編集
      get edit_course_path(course)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
      # 更新
      patch course_path(course), params: {
        course: {
          name: "大神戸ゴルフ場",
          description: "四季折々の風景が楽しめるコースとなっております",
          tips: "バンカーが多くて難しい場面もありますが、OBが出にくいコースとなっています",
          reference: "https://cookpad.com/recipe/2798655",
          score: 100,
          recommend: 5
        }
      }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end

  context "別アカウントのユーザーの場合" do
    it "ホーム画面にリダイレクトすること" do
      login_for_request(other_user)
      get edit_course_path(course)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
      # 更新
      patch course_path(course), params: {
        course: {
          name: "大神戸ゴルフ場",
          description: "四季折々の風景が楽しめるコースとなっております",
          tips: "バンカーが多くて難しい場面もありますが、OBが出にくいコースとなっています",
          reference: "https://cookpad.com/recipe/2798655",
          score: 100,
          recommend: 4
        }
      }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end
end
