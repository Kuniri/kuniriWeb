class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to '/kuniri'
		else
			redirect_to '/sign_up'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted!"
		redirect_to '/home_page'
	end

	private
		def user_params
			params.require(:user).permit(:first_name,:last_name, :email, :password)
		end

		# Confirms a logged-in user.
		def logged_in_user
			unless logged_in?
				flash[:danger] = "Please, log in."
				redirect_to '/login'
			end
    		end

		# Confirms the correct user.
		def correct_user
			@user = User.find(params[:id])
			redirect_to('/home_page') unless current_user?(@user)
		end

end
