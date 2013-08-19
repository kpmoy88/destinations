class GalleriesController < ApplicationController
	before_action :authenticate_user!, :only => [:create,:edit,:update,:destroy]
	before_action :load_nav, :only => [:show]
	before_action :load_location, :only => [:create,:show]
	before_action :load_photo, :only => [:show,:destroy]

	def create
		if params[:gallery][:photo].nil? || params[:gallery][:title] == ""
			flash[:notice] = "Photo was not submitted successfully. Must supply title and picture to be submitted."
		else
			#Sumbit photo that is associated to the location and user
			@gallery =Gallery.new(params.require('gallery').permit(:title,:photo))
			@gallery.title = params[:gallery][:title]
			@gallery.photo = params[:gallery][:photo]
			@gallery.location_id = @location.id
			@gallery.user_id = current_user.id
			if @gallery.save
				flash[:notice] = "Photo was submitted successfully."
			else
				flash[:notice] = "Photo was not submitted successfully."
			end
		end
		redirect_to_location_tab
	end

	def show
		@photo = Gallery.find(params[:id])
	end

	def destroy
		@photo.destroy
		respond_to do |format|
			flash[:notice] = "Photo was deleted successfully."
			format.html {redirect_to_location_tab}
		end
	end

	private

	def load_nav
		# Allows navbar attributes to be seen
		@navbartop = true
	end

	def load_location
		@location = Location.find(params[:location_id])
	end

	def load_photo
		@photo = Gallery.find(params[:id])
	end

	def redirect_to_location_tab
		redirect_to location_path(@location,:simpletabs_selected_tab => 'tab2')
	end
end