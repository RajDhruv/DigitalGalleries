class UserController < ApplicationController
	before_action :set_user,only:[:show, :new_painting]
	before_action :authenticate_user!, except:[:show, :show_painting, :index]
	def index
		@users=User.all
	end
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
		@painting=Painting.new(name: params[:painting][:name], user:current_user)
		if @painting.save
			if params[:painting][:privacy]=="0"
				@painting.public_painting!
			else
				@painting.private_painting!
			end
			@image=Image.new(imageable:@painting, location:  params[:painting][:image][:location])
			@image.save
		end
		@owner = current_user
		@user = current_user
		get_user_paintings(@owner)
		render partial: 'user_redirection.js.erb', locals:{from: :create_painting}
	end

	def get_user_paintings(owner)
		if owner
			@paintings=@user.paintings.recent.includes(:image)
		else
			@paintings=Painting.where(user:@user,privacy:false).recent.includes(:image)
		end
	end

	def change_painting_privacy
		@painting=Painting.find_by_id params[:painting_id]
		if current_user==@painting.user
			if @painting.private_painting?
				@painting.public_painting!
			else
				@painting.private_painting!
			end
		end
		render nothing:true
	end

	private
	def set_user
		@user=User.find_by_id params[:id]
	end

end
