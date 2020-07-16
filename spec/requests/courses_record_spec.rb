require "rails_helper"

RSpec.describe "コース登録", type: :request do
  let!(:user) { create(:user) }
  let!(:course) { create(:course, user: user) }
  let(:picture_path) { File.join(Rails.root, 'spec/fixtures/test_course.jpg') }
  let(:picture) { Rack::Test::UploadedFile.new(picture_path) }

  context "ログインしているユーザーの場合" do
    before do
      get new_course_path
      login_for_request(user)
    end

    context "フレンドリーフォワーディング" do
      it "レスポンスが正常に表示されること" do
        expect(response).to redirect_to new_course_url
      end
    end
  end

  context "ログインしていないユーザーの場合" do
    before do
      login_for_request(user)
      get new_course_path
    end

    it "レスポンスが正常に表示されること" do
      expect(response).to have_http_status "200"
      expect(response).to render_template('courses/new')
    end

    it "有効なコースデータで登録できること" do
      expect {
        post courses_path, params: {
          course: {
            name: "大神戸ゴルフ場",
            description: "四季折々の風景が楽しめるコースとなっております",
            tips: "バンカーが多くて難しい場面もありますが、OBが出にくいコースとなっています",
            reference: "https://cookpad.com/recipe/2798655",
            score: 100,
            recommend: 5,
            picture: picture
          }
        }
      }.to change(Course, :count).by(1)
      follow_redirect!
      expect(response).to render_template('static_pages/home')
    end

    it "無効なコースデータでは登録できないこと" do
      expect {
        post courses_path, params: {
          course: {
            name: "",
            description: "冬に食べたくなる、身体が温まるコースです",
            tips: "ピリッと辛めに味付けするのがオススメ",
            reference: "https://cookpad.com/recipe/2798655",
            score: 100,
            recommend: 5,
            picture: picture
          }
        }
      }.not_to change(Course, :count)
      expect(response).to render_template('courses/new')
    end
  end
end
