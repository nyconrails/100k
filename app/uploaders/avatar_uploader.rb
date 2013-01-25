# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  # include CarrierWave::ImageScience

  # Choose what kind of storage to use for this uploader:
  #storage :file
  storage :fog

  version :thumb do
    process :resize_to_fill => [120, 120]
  end

  version :regular do
    process :resize_to_fit => [240, 90]
  end

  version :grey_tile do
    #process :convert => 'png'
    process :create_rollovers => [120, 120]

    def full_filename (for_file = model.avatar.file)
      "small.png"
    end
  end

  version :grey_rollover_sprite do
    #process :convert => 'png'
    process :create_rollover_sprite => [120, 120]
    def full_filename (for_file = model.avatar.file)
      "small_sprite.png"
    end
  end

  def create_rollovers(width,height)
    # manipulate!(:format=>:png) do |img|
    #   img.fuzz='5%'
    #   img.resize_to_fit!(width-10,height-10)
    #   img=img.transparent('white')
    #
    #   tile=Magick::Image.read(Rails.root+'app/uploaders/logo_grey_tile.png')
    #   tile[0].composite!(img,Magick::CenterGravity,Magick::OverCompositeOp)
    #   img=tile[0]
    # end
  end

  def create_rollover_sprite(width,height)
    # manipulate!(:format=>:png) do |img|
    #   base   = Magick::Image.new(width, height)
    #   img    =img.resize_to_fit(width - 10, height - 10)
    #   sprite = Magick::Image.new(width, height * 2)
    #   sprite_mask = Magick::Image.read(Rails.root+'app/uploaders/logo_grey_black_sprite.png').first
    #
    #   # extend edges to tile size
    #   img = base.composite(img, Magick::CenterGravity, Magick::OverCompositeOp)
    #   sprite.composite!(img, Magick::SouthWestGravity, Magick::OverCompositeOp)
    #   sprite.composite!(sprite_mask, Magick::CenterGravity, Magick::OverCompositeOp)
    #
    #   # make white transparent
    #   img.fuzz = '5%'
    #   img = img.transparent('white')
    #   # apply image on light part of sprite
    #   sprite.composite!(img, Magick::NorthWestGravity,Magick::OverCompositeOp)
    #
    #   img=sprite
    # end
  end

#   def filename
#     "original.#{model.logo.file.extension}" if original_filename
#   end

  #version :medium do
  #  process :resize_and_pad => [450, 450, background=:transparent]
  #end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
