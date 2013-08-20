CarrierWave.configure do |config|
  config.storage = :upyun
  config.upyun_username = "zcpdog"
  config.upyun_password = 'zcp2746257'
  config.upyun_bucket = "xhbimage"
  config.upyun_bucket_domain = "xhbimage.b0.upaiyun.com"
end