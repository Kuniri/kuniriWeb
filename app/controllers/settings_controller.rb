class SettingsController < ApplicationController

	def profile
	end
	
	#first logout
	#second destroy user
	def delete_account
		redirect_to '/logout'
		User.find_by_id(current_user.id).destroy
		flash[:success] = "User deleted!"
	end

end
