require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      # Amazon S3用の設定
      :provider              => 'AWS',
      :region                => 'ap-northeast-1',
      :aws_access_key_id     => 'AKIA5HBHRLQMP2ELIKGS',
      :aws_secret_access_key => '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',
    }
    config.fog_directory     =  'rails-photo-golf'
    config.cache_storage = :fog
  end
end
