# テスト環境で画像をリサイズしなくてもいい
if Rails.env.test?
  CarrierWave.configure do |config|
    config.enable_processing = false
  end
end
