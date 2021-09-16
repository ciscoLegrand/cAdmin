# module Cadmin
	class ImageUploader < Shrine
			# validations doc shrine
		Attacher.validate do
			validate_max_size 10.megabyte, message: "Archivo demasiado pesado"
			validate_mime_type %w[image/jpg image/jpeg image/png image/webp]
			validate_extension %w[jpg jpeg png webp tiff tif]
		end

		plugin :download_endpoint, prefix: "image"
		#generating document preview
		plugin	:derivation_endpoint, 
						secret_key: 'secret_key',
						prefix: 'derivations/image'
		
		derivation :thumbnail do |file, width,height|
			ImageProcessing::MiniMagick
				.source(file, width, height)
				.loader(page: 0) #specify page number which convert
				.resize_to_limit!(width.to_i, height.to_i)
		end
	end
# end