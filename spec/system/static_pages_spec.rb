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
