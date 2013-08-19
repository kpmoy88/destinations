class LocationsController < ApplicationController
	before_action :authenticate_user!, :only => [:new, :create,:edit,:update]
	before_action :load_nav, :only => [:show,:new,:edit,:index]
	before_action :load_location, :only => [:show,:edit,:update]
	
	def index
		# Remove destination suggestion link from side bar
		@addLocationSuggest = false
		@locations = Location.search(params[:search],params[:search_by])
	end

	def new
		# Allows navbar side to not be seen
		@navbarside = false
		@location = Location.new
	end

	def create
    	@location = Location.new(location_params)
    	@location.date_posted = Time.now
    	@location.user_id = current_user.id

    	#Allows location picture to be uploaded
    	unless params[:location][:image].nil?
    		@location.image = params[:location][:image]
    	end

    	if @location.save
    		flash[:notice] = "Location was submitted successfully."
    		redirect_to @location
    	else
    		flash[:notice] = "Location was not submitted successfully."
    		render 'new'
    	end
	end

	def show
		#Assigns who submitted location to website
		@posted_user = User.find(Location.find(@location.id).user_id)
		#Retrieve all comments on this location
		@commentable = Location.find(params[:id])
		@comments = Comment.where('commentable_id = ?', @commentable.id)
		#Allow for new comments
		@comment = @location.comments.new
		#Retrieve all images in gallery of the location
		@photo_gallery = Gallery.where('location_id = ?', @location.id)
		#Allow a new photo to be added
		@gallery = Gallery.new
		#Check if visited button was pressed
		check_Visited
		#Check if bookmark button was pressed
		check_Bookmark
	end

	def edit
		# Allows navbar side attributes to not be seen
		@navbarside = false
	end

	def update
    	@location.update(location_params)
    	#Allows location picture to be updated
    	unless params[:location][:image].nil?
    		@location.image = params[:location][:image]
    	end

    	if @location.save
    		flash[:notice] = "Location was updated successfully."
    		redirect_to @location
    	else
    		flash[:notice] = "Location was not updated successfully."
    		render 'edit'
    	end
	end

	private

	def load_nav
		# Allows navbar attributes to be seen
		@navbartop = true
		# Allows navbar side attributes to be seen
		@navbarside = true
		# Allows link to add locations to be seen
		@addLocation = true
		# Allows link to location suggestions to be seen
		@addLocationSuggest = true
	end

	def load_location
		@location = Location.find(params[:id])
	end

	def location_params
		params.require('location').permit(:title,:address,:city,:state,:description)
	end

	def check_Visited
		#If Visited button was clicked add to visited list
		if params[:visited] == 'Visited'
			flash[:notice] = "Added location to visited list."
			@visited = Visited.new
			@visited.user_id = current_user.id
			@visited.location_id = @location.id
			@visited.save
			params.delete :visited
			redirect_to location_path(@location.id),:params => params
		end
	end

	def check_Bookmark
		#If Visited button was clicked add to visited list
		if params[:bookmark] == 'Bookmark'
			flash[:notice] = "Added location to bookmark list."
			@bookmark = Bookmark.new
			@bookmark.user_id = current_user.id
			@bookmark.location_id = @location.id
			@bookmark.save
			params.delete :bookmark
			redirect_to location_path(@location.id),:params => params
		end
	end
end