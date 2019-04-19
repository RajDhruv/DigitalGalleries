class UserController < ApplicationController
	before_action :set_user,only:[:show, :new_painting]
	before_action :authenticate_user!, except:[:show, :show_painting]
	def show
		@owner = (current_user==@user) ? true : false
		if @owner
			@image=Image.new
		end
		get_user_paintings(@owner)
		render partial: 'user_redirection.js.erb', locals:{from: :show}
	end

	def create
		@user=current_user
		@image=Image.new
	    @image.location=params[:image][:location]
	    @image.imageable=current_user
		@image.save!
		render partial: 'user_redirection.js.erb', locals:{from: :create}
	end

	def new_painting
		@painting=Painting.new
		render partial: 'user_redirection.js.erb', locals:{from: :new_painting}
	end

	def show_painting
	end

	def create_painting
		@painting=Painting.new(name: params[:painting][:name],privacy: params[:painting][:privacy], user:current_user)
		if @painting.save
			@image=Image.new(imageable:@painting, location:  params[:painting][:image][:location])
			@image.save
		end
		render partial: 'user_redirection.js.erb', locals:{from: :create_painting}
	end

	def get_user_paintings(owner)
		if owner
			@paintings=@user.paintings.includes(:image)
		else
			@paintings=Painting.where(user:@user,privacy:false).includes(:image)
		end
	end
	private
	def set_user
		@user=User.find_by_id params[:id]
	end

end
