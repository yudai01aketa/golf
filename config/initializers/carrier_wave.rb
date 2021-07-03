if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Amazon S3用の設定rai
      :provider              => 'AWS',
      :region                => 'ap-northeast-1',
      :aws_access_key_id     => 'AKIA5HBHRLQMP2ELIKGS',
      :aws_secret_access_key => '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'
    }
    config.fog_directory     =  ENV['S3_AWS_BUCKET']
  end
end
