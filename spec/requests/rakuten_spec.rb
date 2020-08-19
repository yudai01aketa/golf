require 'rails_helper'

RSpec.describe "楽天GORA", type: :request do
  context "楽天コース一覧ページの表示" do
    it "レスポンスが正常に表示されること" do
      get rakuten_index_path
      expect(response).to render_template('rakuten/index')
    end
  end
end
