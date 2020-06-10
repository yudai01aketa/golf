require 'rails_helper'

RSpec.describe "ログ機能", type: :request do
  let!(:user) { create(:user) }
  let!(:course) { create(:course, user: user) }
  let!(:log) { create(:log, course: course) }
  let!(:other_user) { create(:user) }

  context "ログ登録" do
    context "ログインしている場合" do
      context "コースを作成したユーザーである場合" do
        before do
          login_for_request(user)
        end

        it "有効なログが登録できること" do
          expect {
            post logs_path, params: { course_id: course.id,
                                      log: { content: "100切れた" } }
          }.to change(course.logs, :count).by(1)
          expect(response).to redirect_to course_path(course)
        end

        it "無効なログが登録できないこと" do
          expect {
            post logs_path, params: { course_id: nil,
                                      log: { content: "100切れた！" } }
          }.not_to change(course.logs, :count)
        end
      end

      context "コースを作成したユーザーでない場合" do
        it "ログ登録できず、トップページへリダイレクトすること" do
          login_for_request(other_user)
          expect {
            post logs_path, params: { course_id: course.id,
                                      log: { content: "100切れた！" } }
          }.not_to change(course.logs, :count)
          expect(response).to redirect_to root_path
        end
      end
    end

    context "ログインしていない場合" do
      it "ログ登録できず、ログインページへリダイレクトすること" do
        expect {
          post logs_path, params: { course_id: course.id,
                                    log: { content: "OB出なかった!" } }
        }.not_to change(course.logs, :count)
        expect(response).to redirect_to login_path
      end
    end
  end

  context "ログ削除" do
    context "ログインしている場合" do
      context "ログを作成したユーザーである場合" do
        it "ログ削除ができること" do
          login_for_request(user)
          expect {
            delete log_path(log)
          }.to change(course.logs, :count).by(-1)
        end
      end

      context "ログを作成したユーザーでない場合" do
        it "ログ削除はできず、コース詳細ページへリダイレクトすること" do
          login_for_request(other_user)
          expect {
            delete log_path(log)
          }.not_to change(course.logs, :count)
          expect(response).to redirect_to course_path(course)
        end
      end
    end

    context "ログインしていない場合" do
      it "ログ削除はできず、ログインページへリダイレクトすること" do
        expect {
          delete log_path(log)
        }.not_to change(course.logs, :count)
        expect(response).to redirect_to login_path
      end
    end
  end
end
