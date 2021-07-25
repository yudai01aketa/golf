require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: ENV['S3_REGION']
  }

    case Rails.env
    when 'development'
        config.fog_directory  = ENV['S3_BUCKET']
        config.asset_host = ENV['AWS_BUCKET_URL']
    when 'production'
        config.fog_directory  = ENV['S3_BUCKET']
        config.asset_host = ENV['AWS_BUCKET_URL']
    end
end
