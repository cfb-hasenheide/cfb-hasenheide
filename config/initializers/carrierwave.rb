# NOTE: For configuration options see:
# https://github.com/carrierwaveuploader/carrierwave#using-amazon-s3
CarrierWave.configure do |config|
  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  else
    config.fog_provider = 'fog/aws'

    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     Rails.application.secrets.aws_access_key_id,
      aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
      region:                Rails.application.secrets.aws_region,
      path_style:            true
    }

    config.fog_directory  = Rails.application.secrets.aws_bucket
    config.fog_public     = false
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
  end
end
