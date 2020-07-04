require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "トップページ" do
    context "ページ全体" do
      before do
        visit root_path
      end

      it "Enjoy Golfの文字列が存在することを確認" do
        expect(page).to have_content 'Enjoy Golf'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title
      end

      it "ゲストログインが表示されることを確認" do
        expect(page).to have_content 'ゲストログイン'
      end
    end

    context "コースフィード", js: true do
      let!(:user) { create(:user) }
      let!(:course) { create(:course, user: user) }

      it "コースのぺージネーションが表示されること" do
        login_for_system(user)
        create_list(:course, 6, user: user)
        visit root_path
        expect(page).to have_content "みんなのコース (#{user.courses.count})"
        expect(page).to have_css "div.pagination"
        Course.take(5).each do |c|
          expect(page).to have_link c.name
        end
      end
    end
  end

  describe "ヘルプページ" do
    before do
      visit about_path
    end

    it "Enjoy Golfとは？の文字列が存在することを確認" do
      expect(page).to have_content 'Enjoy Golfとは？'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('Enjoy Golfとは？')
    end
  end
end
