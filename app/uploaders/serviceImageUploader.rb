class ServiceImageUploader < Shrine
  # # validations doc shrine
  # Attacher.validate do
  #   validate_max_size 10.megabyte, message: "Archivo demasiado pesado"
  #   validate_mime_type %w[image/jpg image/jpeg image/png image/webp]
  #   validate_extension %w[jpg jpeg png webp tiff tif]
  # end

  # Attacher.derivatives do |original|
  #   magick = ImageProcessing::MiniMagick.source(original)
 
  #   { 
  #     mobile:  magick.resize_to_limit!(300, 0),
  #     desktop: magick.resize_to_limit!(1200, 0),
  #     fullhd:  magick.resize_to_limit!(1500, 0),
  #   }
  # end
end