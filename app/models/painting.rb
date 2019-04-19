class Painting < ApplicationRecord
  belongs_to :user
  has_one :image, as: :imageable, dependent: :destroy
end
