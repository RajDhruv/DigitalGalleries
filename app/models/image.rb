class Image < ApplicationRecord
	belongs_to :imageable,polymorphic: true
	mount_uploader :location, AvatarUploader
	after_save :set_latest_image

	def set_latest_image
		if self.imageable.class.to_s=="User"
			self.imageable.update_attribute('image_id', self.id)
		end
	end
end
