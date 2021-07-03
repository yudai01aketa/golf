if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Amazon S3用の設定
      :provider              => 'AWS',
      :region                => ENV['S3_AWS_REGION'],
      :aws_access_key_id     => ENV['S3_AWS_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_AWS_SECRET_KEY']
    }
    config.fog_directory     =  ENV['S3_AWS_BUCKET']
  end
end
