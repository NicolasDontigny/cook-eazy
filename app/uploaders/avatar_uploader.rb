class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def default_url(avatar)
    "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end
  # Remove everything else
end
