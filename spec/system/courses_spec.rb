require 'rails_helper'

RSpec.describe "Courses", type: :system do
  let!(:user) { create(:user) }
  let!(:course) { create(:course, :picture, user: user) }
  let!(:other_user) { create(:user) }
  let!(:comment) { create(:comment, user_id: user.id, course: course) }

  describe "コース登録ページ" do
    before do
      login_for_system(user)
      visit new_course_path
    end

    context "ページレイアウト" do
      it "「コース登録」の文字列が存在すること" do
        expect(page).to have_content 'コース登録'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('コース登録')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content 'コース名'
        expect(page).to have_content '説明'
        expect(page).to have_content 'コツ・ポイント'
        expect(page).to have_content 'コースの詳細URL'
        expect(page).to have_content 'スコア'
        expect(page).to have_content 'オススメ度'
        expect(page).to have_content 'ラウンドメモ'
      end
    end

    context "コース登録処理" do
      it "有効な情報で料理登録を行うとコース登録成功のフラッシュが表示されること" do
        fill_in "コース名", with: "大神戸"
        fill_in "説明", with: "四季折々の風景が楽しめるコースとなっております"
        fill_in "コツ・ポイント", with: "バンカーが多くて難しい場面もありますが、OBが出にくいコースとなっています"
        fill_in "コースの詳細URL", with: "https://cookpad.com/recipe/2798655"
        fill_in "スコア", with: 100
        fill_in "オススメ度", with: 5
        attach_file "course[picture]", "#{Rails.root}/spec/fixtures/test_course.jpg"
        click_button "登録する"
        expect(page).to have_content "コースが登録されました！"
      end

      it "無効な情報でコース登録を行うと料理登録失敗のフラッシュが表示されること" do
        fill_in "コース名", with: ""
        fill_in "説明", with: "四季折々の風景が楽しめるコースとなっております"
        fill_in "コツ・ポイント", with: "バンカーが多くて難しい場面もありますが、OBが出にくいコースとなっています"
        fill_in "コースの詳細URL", with: "https://cookpad.com/recipe/2798655"
        fill_in "スコア", with: 100
        fill_in "オススメ度", with: 5
        click_button "登録する"
        expect(page).to have_content "コース名を入力してください"
      end
    end
  end

  describe "コース詳細ページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        visit course_path(course)
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{course.name}")
      end

      it "コース情報が表示されること" do
        expect(page).to have_content course.name
        expect(page).to have_content course.description
        expect(page).to have_content course.tips
        expect(page).to have_content course.reference
        expect(page).to have_content course.score
        expect(page).to have_content course.recommend
      end

      context "コースの削除", js: true do
        it "削除成功のフラッシュが表示されること" do
          login_for_system(user)
          visit course_path(course)
          within find('.change-course') do
            click_on '削除'
          end
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content 'コースが削除されました'
        end
      end
    end
  end

  describe "コース編集ページ" do
    before do
      login_for_system(user)
      visit course_path(course)
      click_link "編集"
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('コース情報の編集')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content 'コース名'
        expect(page).to have_content '説明'
        expect(page).to have_content 'コツ・ポイント'
        expect(page).to have_content 'コースの詳細URL'
        expect(page).to have_content 'スコア'
        expect(page).to have_content 'オススメ度 [1~5]'
      end
    end

    context "コースの更新処理" do
      it "有効な更新" do
        fill_in "コース名", with: "編集：大神戸"
        fill_in "説明", with: "四季折々の風景が楽しめるコースです、六甲の絶景をお楽しみ下さい"
        fill_in "コツ・ポイント", with: "編集：バンカーが多くて難しい場面もありますが、OBが出にくいコースとなっています"
        fill_in "コースの詳細URL", with: "henshu-https://cookpad.com/recipe/2798655"
        fill_in "スコア", with: 100
        fill_in "オススメ度", with: 4
        attach_file "course[picture]", "#{Rails.root}/spec/fixtures/test_course2.jpg"
        click_button "更新する"
        expect(page).to have_content "コース情報が更新されました！"
        expect(course.reload.name).to eq "編集：大神戸"
        expect(course.reload.description).to eq "四季折々の風景が楽しめるコースです、六甲の絶景をお楽しみ下さい"
        expect(course.reload.tips).to eq "編集：バンカーが多くて難しい場面もありますが、OBが出にくいコースとなっています"
        expect(course.reload.reference).to eq "henshu-https://cookpad.com/recipe/2798655"
        expect(course.reload.score).to eq 100
        expect(course.reload.recommend).to eq 4
        expect(course.reload.picture.url).to include "test_course2.jpg"
      end

      it "無効な更新" do
        fill_in "コース名", with: ""
        click_button "更新する"
        expect(page).to have_content 'コース名を入力してください'
        expect(course.reload.name).not_to eq ""
      end

      context "コースの削除処理", js: true do
        it "削除成功のフラッシュが表示されること" do
          click_on '削除'
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content 'コースが削除されました'
        end
      end
    end

    context "コメントの登録＆削除" do
      it "自分のコースに対するコメントの登録＆削除が正常に完了すること" do
        login_for_system(user)
        visit course_path(course)
        fill_in "comment_content", with: "今日のラウンド最高"
        click_button "コメント"
        within find("#comment-#{Comment.last.id}") do
          expect(page).to have_selector 'span', text: user.name
          expect(page).to have_selector 'span', text: '今日のラウンド最高'
        end
        expect(page).to have_content "コメントを追加しました！"
        click_link "削除", href: comment_path(Comment.last)
        expect(page).not_to have_selector 'span', text: '今日のラウンド最高'
        expect(page).to have_content "コメントを削除しました"
      end

      it "別ユーザーのコースのコメントには削除リンクが無いこと" do
        login_for_system(other_user)
        visit course_path(course)
        within find("#comment-#{comment.id}") do
          expect(page).to have_selector 'span', text: user.name
          expect(page).to have_selector 'span', text: comment.content
          expect(page).not_to have_link '削除', href: course_path(course)
        end
      end
    end
  end

  context "ログ登録＆削除" do
    context "コース詳細ページから" do
      it "自分のコースに対するログ登録＆削除が正常に完了すること" do
        login_for_system(user)
        visit course_path(course)
        fill_in "log_content", with: "ログ投稿テスト"
        click_button "ログ追加"
        within find("#log-#{Log.first.id}") do
          expect(page).to have_selector 'span', text: "#{course.logs.count}回目"
          expect(page).to have_selector 'span',
                                        text: %Q(#{Log.last.created_at.strftime("%Y/%m/%d(%a)")})
          expect(page).to have_selector 'span', text: 'ログ投稿テスト'
        end
        expect(page).to have_content "コースログを追加しました！"
        click_link "削除", href: log_path(Log.first)
        expect(page).not_to have_selector 'span', text: 'ログ投稿テスト'
        expect(page).to have_content "コースログを削除しました"
      end

      it "別ユーザーのコースログにはログ登録フォームが無いこと" do
        login_for_system(other_user)
        visit course_path(course)
        expect(page).not_to have_button "作る"
      end
    end

    context "トップページから" do
      it "自分のコースに対するログ登録が正常に完了すること" do
        login_for_system(user)
        visit root_path
        fill_in "log_content", with: "ログ投稿テスト"
        click_button "追加"
        expect(Log.first.content).to eq 'ログ投稿テスト'
        expect(page).to have_content "コースログを追加しました！"
      end

      it "別ユーザーのコースにはログ登録フォームがないこと" do
        create(:course, user: other_user)
        login_for_system(user)
        user.follow(other_user)
        visit root_path
        within find("#course-#{Course.first.id}") do
          expect(page).not_to have_button "作る"
        end
      end
    end

    context "プロフィールページから" do
      it "自分の料理に対するログ登録が正常に完了すること" do
        login_for_system(user)
        visit user_path(user)
        fill_in "log_content", with: "ログ投稿テスト"
        click_button "追加"
        expect(Log.first.content).to eq 'ログ投稿テスト'
        expect(page).to have_content "コースログを追加しました！"
      end
    end

    context "リスト一覧ページから" do
      it "自分のコースに対するログ登録が正常に完了し、リストからコースが削除されること" do
        login_for_system(user)
        user.list(course)
        visit lists_path
        expect(page).to have_content course.name
        fill_in "log_content", with: "ログ投稿テスト"
        click_button "追加"
        expect(Log.first.content).to eq 'ログ投稿テスト'
        expect(page).to have_content "コースログを追加しました！"
        expect(List.count).to eq 0
      end
    end
  end
end
