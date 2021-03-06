class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		error_message = ""

		if @user.password != @user.password_confirmation
			error_message = "password do not match!"
			flash[:notice] = error_message
			redirect_to '/sign_up' and return
#			render :partial => "users/new", :locals => {:first_name => @user.first_name ,:last_name => @user.last_name, :email => @user.email} and return
		end

		if User.find_by_email(@user.email)
			if error_message == ""
				error_message = "e-mail was alredy registered"
			else
				error_message = error_message + "\n e-mail was alredy registered!"
			end
			
			flash[:notice] = error_message
			redirect_to '/sign_up' and return
		end

		if @user.save
			session[:user_id] = @user.id
			redirect_to '/kuniri' 
		else
			redirect_to '/sign_up'
		end
	end

	def edit
		@user = User.find(current_user.id)
	end

	def update
		if @user.update_attributes(user_params)
			flash[:notice] = "Profile updated!"
			redirect_to '/settings'
		else
			flash[:notice] = "Password do not match!"
			render 'users/edit'
    		end
  	end

	def destroy
		User.find(params[:id]).destroy
		flash[:notice] = "User deleted with success!"
		redirect_to '/kuniri'
	end

	def destroy_user
		redirect_to '/logout'
		User.find_by_id(current_user.id).destroy
		flash[:notice] = "User account deleted with success!"
	end

	private
		def user_params
			params.require(:user).permit(:first_name,:last_name, :email, :password,:password_confirmation)
		end

		# Confirms a logged-in user.
		def logged_in_user
			unless logged_in?
				flash[:notice] = "Please, log in."
				redirect_to '/login'
			end
    		end

		# Confirms the correct user.
		def correct_user
			@user = User.find(current_user.id)
			if not current_user
				redirect_to('/kuniri') #unless current_user?(@user)
			end
		end

		# Confirms an admin user.
		def admin_user
			redirect_to('/kuniri') unless current_user.admin?
		end

end
