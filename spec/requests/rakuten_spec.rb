require 'rails_helper'

RSpec.describe "楽天GORA", type: :request do
  context "通知一覧ページの表示" do
    it "レスポンスが正常に表示されること" do
      get rakuten_index
      expect(response).to render_template('rakuten')
    end
  end
end
