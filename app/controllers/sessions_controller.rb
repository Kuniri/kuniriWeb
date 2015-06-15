class SessionsController < ApplicationController
	
  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])

		if @user.password.nil?
    	flash.now[:error] = 'Invalid Password. Password is nil'			
			redirect_to 'login'
		end

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to '/kuniri'
    else
    	flash.now[:error] = 'Invalid email/password combination'
      redirect_to 'login'
    end  
  end
  
end
