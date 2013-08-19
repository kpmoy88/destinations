class ProfilesController < ApplicationController
	before_action :authenticate_user!, :only => [:edit,:update]
	before_action :load_nav, :only => [:show,:edit]
	before_action :load_user, :only => [:show]
	before_action :load_profile, :only => [:show, :edit, :update]
	before_action :load_posted_locations, :only => [:show]
	before_action :load_visited_locations, :only => [:show]
	before_action :load_bookmark_locations, :only => [:show]

	def new
	end

	def show
		# Allows "Sign Out" and "Profile" links in NavBar
		@navbartop = true
		remove_From_Visited
		remove_From_Bookmark
	end

	def edit
	end

	def update
    	@profile.update(params.require('profile').permit(:first_name,:last_name,:city, :state, :bio))
    	#Allows avatar picture to be uploaded
    	unless params[:profile][:avatar].nil?
    		@profile.avatar = params[:profile][:avatar]
    	end

    	if @profile.save
    		flash[:notice] = "Profile was updated successfully."
    		redirect_to @profile
    	else
    		flash[:notice] = "Profile was not updated successfully."
    	  	render 'edit'
    	end
	end

	private

	def load_nav
		# Allows navbar attributes to be seen
		@navbartop = true
	end

	def load_user
		@user = User.find(params[:id])
	end

	def load_profile
		@profile = Profile.find(params[:id])
	end

	#Load all the location posts the user posted
	def load_posted_locations
    	@locations = Location.where( "user_id = ?", params[:id])
  	end

  	#Load all the visited location on user's visited list
	def load_visited_locations
    	@visited = Visited.where( "user_id = ?", params[:id])
  	end

  	#Load all the bookmark location on user's bookmark list
	def load_bookmark_locations
    	@bookmarks = Bookmark.where( "user_id = ?", params[:id])
  	end

  	def remove_From_Visited
  		#Remove location from visited list when remove button is clicked
		if params[:visited] == 'Remove'
			flash[:notice] = "Deleted location from visited list."
			@visited = Visited.find_by(:user_id => @profile.user_id, :location_id => params[:location_id])
			Visited.destroy(@visited)
			params.delete :visited
			redirect_to profile_path(@profile.id,:simpletabs_selected_tab => 'tab3'),:params => params
		end
	end

	def remove_From_Bookmark
  		#Remove location from bookmark list when remove button is clicked
		if params[:bookmark] == 'Remove'
			flash[:notice] = "Deleted location from bookmark list."
			@bookmark = Bookmark.find_by(:user_id => @profile.user_id, :location_id => params[:location_id])
			Bookmark.destroy(@bookmark)
			params.delete :bookmark
			redirect_to profile_path(@profile.id,:simpletabs_selected_tab => 'tab4'),:params => params
		end
	end
end