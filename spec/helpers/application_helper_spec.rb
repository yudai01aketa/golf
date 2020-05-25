require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  include ApplicationHelper

  describe "タイトルの表示" do
    it 'トップページのタイトルの表示' do
      expect(full_title('')).to match('Enjoy Golf')
    end
  end
end
