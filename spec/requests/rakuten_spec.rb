require 'rails_helper'

RSpec.describe "楽天GORA", type: :request do
  context "通知一覧ページの表示" do
    it "レスポンスが正常に表示されること" do
      get rakuten
      expect(response).to render_template('rakuten_index')
    end
  end
end
