class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :images, as: :imageable, dependent: :destroy
  has_many :paintings, dependent: :destroy
  def self.get_all_users
  	#TODO Add Pagination
  	User.all
  end
end
