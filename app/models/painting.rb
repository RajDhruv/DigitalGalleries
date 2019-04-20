class Painting < ApplicationRecord
	belongs_to :user
	has_one :image, as: :imageable, dependent: :destroy
	enum privacy:{public_painting: 0, private_painting: 1}
	scope :recent, -> { order("created_at DESC") }

end