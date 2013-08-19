class CommentsController < ApplicationController
	before_action :authenticate_user!, :only => [:create,:edit,:update,:destroy]
	before_action :load_nav, :only => [:edit]
	before_action :load_location, :only => [:create,:edit,:update,:destroy]
	before_action :load_comment, :only => [:edit,:update,:destroy]

	def create
		#Create a comment that is associated to the location and user
		@comment = Comment.new(params.require('comment').permit(:comment))
		@comment.commentable_id = @location.id
		@comment.user_id = current_user.id
		flash[:notice] = "Comment was submitted successfully."
		save_and_redirect(@comment)
	end

	def edit
	end

	def update
		@comment.update(params.require('comment').permit(:comment))
		flash[:notice] = "Comment was updated successfully."
		save_and_redirect(@comment)
	end

	def destroy
		@comment.destroy
		respond_to do |format|
			flash[:notice] = "Comment was deleted successfully."
			format.html {redirect_to_Location}
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

	def load_comment
		@comment = Comment.find(params[:id])
	end

	def save_and_redirect(comment)
		unless comment.save
			flash[:notice] = "Comment was not submitted. Comment cannot be blank"
		end
		redirect_to_Location
	end

	def redirect_to_Location
		redirect_to location_path(@location,:simpletabs_selected_tab => 'tab3')
	end
end