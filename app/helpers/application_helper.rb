module ApplicationHelper
	def profile_display_image(user)
		user_profile=Image.find_by_id(user.image_id)
	    user_profile=user_profile.nil? ? asset_path("default_logos/default_profile.png") : user_profile.location.url
	end
end
