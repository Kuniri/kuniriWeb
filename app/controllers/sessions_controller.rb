class SessionsController < ApplicationController
	
  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])

    if @user == nil
    	flash[:notice] = 'User not find. Please register a new user'
    	render 'sessions/new' and return
    end

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = 'Success on login'
		  redirect_to '/kuniri' and return
    else
    	flash[:notice] = 'Invalid email/password combination'
      render 'sessions/new' and return
    end
  end
  
	def destroy
 		session[:user_id] = nil
 		redirect_to '/kuniri'
 	end
 
 	
end
