aws_credentials = YAML
  .load(ERB.new(File.read('config/aws_credentials.yml')).result)
  .fetch(Rails.env)

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     aws_credentials['aws_access_key_id'],
    aws_secret_access_key: aws_credentials['aws_secret_access_key'],
    region:                aws_credentials['region'],
    # host:                  's3.example.com',             # optional, defaults to nil
    # endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
  }
  config.fog_directory  = aws_credentials['s3_bucket']
  config.fog_public     = false                                        # optional, defaults to true
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
end
