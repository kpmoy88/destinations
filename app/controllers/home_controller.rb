class HomeController < ApplicationController
	before_action :load_nav

	def index
		#Get the 5 most recent location posts
		@locations = Location.limit(5).order('id desc')
		#get the 5 most recent photos that were posted in a locations' gallery
		@photos = Gallery.limit(18).order('id desc')
	end

	private

	def load_nav
		# Allows navbar header attributes to be seen
		@navbartop = true
		# Allows navbar side attributes to be seen
		@navbarside = true
		# Allows link to add locations to be seen
		@addLocation = true
		# Allows link to location suggestions to be seen
		@addLocationSuggest = true
	end
end