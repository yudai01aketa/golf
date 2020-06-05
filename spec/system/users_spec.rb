require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }
  let!(:admin_user) { create(:user, :admin) }
  let!(:other_user) { create(:user) }
  let!(:course) { create(:course, user: user) }
  let!(:other_course) { create(:course, user: other_user) }

  describe "ユーザー一覧ページ" do
    it "ぺージネーション、削除ボタンが表示されること" do
      create_list(:user, 31)
      login_for_system(user)
      visit users_path
      expect(page).to have_css "div.pagination"
      User.paginate(page: 1).each do |u|
        expect(page).to have_link u.name, href: user_path(u)
      end
    end
  end

  describe "ユーザー登録ページ" do
    before do
      visit signup_path
    end

    context "ページレイアウト" do
      it "「ユーザー登録」の文字列が存在することを確認" do
        expect(page).to have_content 'ユーザー登録'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('ユーザー登録')
      end

      context "ユーザー登録処理" do
        it "有効なユーザーでユーザー登録を行うとユーザー登録成功のフラッシュが表示されること" do
          fill_in "ユーザー名", with: "Example User"
          fill_in "メールアドレス", with: "user@example.com"
          fill_in "パスワード", with: "password"
          fill_in "パスワード(確認)", with: "password"
          click_button "登録する"
          expect(page).to have_content "Enjoy Golf！"
        end

        it "無効なユーザーでユーザー登録を行うとユーザー登録失敗のフラッシュが表示されること" do
          fill_in "ユーザー名", with: ""
          fill_in "メールアドレス", with: "user@example.com"
          fill_in "パスワード", with: "password"
          fill_in "パスワード(確認)", with: "pass"
          click_button "登録する"
          expect(page).to have_content "ユーザー名を入力してください"
          expect(page).to have_content "パスワード(確認)とパスワードの入力が一致しません"
        end
      end
    end

    describe "プロフィール編集ページ" do
      before do
        login_for_system(user)
        visit user_path(user)
        click_link "プロフィール編集"
      end

      context "ページレイアウト" do
        it "正しいタイトルが表示されることを確認" do
          expect(page).to have_title full_title('プロフィール編集')
        end
      end

      it "有効なプロフィール更新を行うと、更新成功のフラッシュが表示されること" do
        fill_in "ユーザー名", with: "Edit Example User"
        fill_in "メールアドレス", with: "edit-user@example.com"
        fill_in "自己紹介", with: "編集：初めまして"
        fill_in "性別", with: "編集：男性"
        click_button "更新する"
        expect(page).to have_content "プロフィールが更新されました！"
        expect(user.reload.name).to eq "Edit Example User"
        expect(user.reload.email).to eq "edit-user@example.com"
        expect(user.reload.introduction).to eq "編集：初めまして"
        expect(user.reload.sex).to eq "編集：男性"
      end

      it "無効なプロフィール更新をしようとすると、適切なエラーメッセージが表示されること" do
        fill_in "ユーザー名", with: ""
        fill_in "メールアドレス", with: ""
        click_button "更新する"
        expect(page).to have_content 'ユーザー名を入力してください'
        expect(page).to have_content 'メールアドレスを入力してください'
        expect(page).to have_content 'メールアドレスは不正な値です'
        expect(user.reload.email).not_to eq ""
      end

      context "アカウント削除処理", js: true do
        it "正しく削除できること" do
          click_link "アカウントを削除する"
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content "自分のアカウントを削除しました"
        end
      end
    end

    describe "プロフィールページ" do
      context "ページレイアウト" do
        before do
          login_for_system(user)
          create_list(:course, 10, user: user)
          visit user_path(user)
        end

        it "「プロフィール」の文字列が存在することを確認" do
         expect(page).to have_content 'プロフィール'
        end

        it "正しいタイトルが表示されることを確認" do
         expect(page).to have_title full_title('プロフィール')
        end

        it "ユーザー情報が表示されることを確認" do
         expect(page).to have_content user.name
         expect(page).to have_content user.introduction
         expect(page).to have_content user.sex
        end

        it "プロフィール編集ページへのリンクが表示されていることを確認" do
          expect(page).to have_link 'プロフィール編集', href: edit_user_path(user)
        end

        it "コースの件数が表示されていることを確認" do
          expect(page).to have_content "コース (#{user.courses.count})"
        end

        it "コースの情報が表示されていることを確認" do
          Course.take(5).each do |course|
            expect(page).to have_link course.name
            expect(page).to have_content course.description
            expect(page).to have_content course.user.name
            expect(page).to have_content course.score
            expect(page).to have_content course.recommend
          end
        end

        it "コースのページネーションが表示されていることを確認" do
          expect(page).to have_css "div.pagination"
        end

        context "ユーザーのフォロー/アンフォロー処理", js: true do
          it "ユーザーのフォロー/アンフォローができること" do
            login_for_system(user)
            visit user_path(other_user)
            expect(page).to have_button 'フォローする'
            click_button 'フォローする'
            expect(page).to have_button 'フォロー中'
            click_button 'フォロー中'
            expect(page).to have_button 'フォローする'
          end
        end

        context "お気に入り登録/解除" do
          before do
            login_for_system(user)
          end

          it "コースのお気に入り登録/解除ができること" do
            expect(user.favorite?(course)).to be_falsey
            user.favorite(course)
            expect(user.favorite?(course)).to be_truthy
            user.unfavorite(course)
            expect(user.favorite?(course)).to be_falsey
          end

          it "トップページからお気に入り登録/解除ができること", js: true do
            visit root_path
            link = find('.like')
            expect(link[:href]).to include "/favorites/#{course.id}/create"
            link.click
            link = find('.unlike')
            expect(link[:href]).to include "/favorites/#{course.id}/destroy"
            link.click
            link = find('.like')
            expect(link[:href]).to include "/favorites/#{course.id}/create"
          end

          it "ユーザー個別ページからお気に入り登録/解除ができること", js: true do
            visit user_path(user)
            link = find('.like')
            expect(link[:href]).to include "/favorites/#{course.id}/create"
            link.click
            link = find('.unlike')
            expect(link[:href]).to include "/favorites/#{course.id}/destroy"
            link.click
            link = find('.like')
            expect(link[:href]).to include "/favorites/#{course.id}/create"
          end

          it "コース個別ページからお気に入り登録/解除ができること", js: true do
            visit course_path(course)
            link = find('.like')
            expect(link[:href]).to include "/favorites/#{course.id}/create"
            link.click
            link = find('.unlike')
            expect(link[:href]).to include "/favorites/#{course.id}/destroy"
            link.click
            link = find('.like')
            expect(link[:href]).to include "/favorites/#{course.id}/create"
          end
        end

        it "お気に入り一覧ページが期待通り表示されること" do
          visit favorites_path
          expect(page).not_to have_css ".favorite-course"
          user.favorite(course)
          user.favorite(other_course)
          visit favorites_path
          expect(page).to have_css ".favorite-course", count: 2
          expect(page).to have_content course.name
          expect(page).to have_content course.description
          expect(page).to have_content "cooked by #{user.name}"
          expect(page).to have_link user.name, href: user_path(user)
          expect(page).to have_content other_course.name
          expect(page).to have_content other_course.description
          expect(page).to have_content "cooked by #{other_user.name}"
          expect(page).to have_link other_user.name, href: user_path(other_user)
          user.unfavorite(other_course)
          visit favorites_path
          expect(page).to have_css ".favorite-course", count: 1
          expect(page).to have_content course.name
        end
      end
    end
  end
end