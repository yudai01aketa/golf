require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
    config.enable_processing = false if Rails.env.test?
  elsif Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
      region: ENV['S3_REGION']
    }
    config.storage = :fog
    config.fog_directory = ENV['S3_BUCKET']
    config.asset_host = ENV['AWS_BUCKET_URL']
  end
end
