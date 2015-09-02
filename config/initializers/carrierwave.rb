aws_credentials = YAML
  .load(ERB.new(File.read('config/aws_credentials.yml')).result)
  .fetch(Rails.env)

# NOTE: For configuration options see:
# https://github.com/carrierwaveuploader/carrierwave#using-amazon-s3
CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'

  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     aws_credentials['aws_access_key_id'],
    aws_secret_access_key: aws_credentials['aws_secret_access_key'],
    region:                aws_credentials['region'],
  }

  config.fog_directory  = aws_credentials['s3_bucket']
  config.fog_public     = false
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
end
