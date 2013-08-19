class RegistrationsController < Devise::RegistrationsController
	view_paths = "app/views/devise"

	def create
		super
		#Creates profile to be associated with user
		@profile = Profile.new
		@profile.user_id = @user.id
		@profile.save
	end

	protected

	def sign_up_params
		params.require(:user).permit(:username,:email,:password,:password_confirmation)
	end

end