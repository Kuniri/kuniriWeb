class SessionsController < ApplicationController
	
  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])

    if @user.nil?
    	flash.now[:error] = 'Invalid User. user do not registered'
    	#redirect_to 'login' and return
    end    	

		if @user.password.nil?
    	flash.now[:error] = 'Invalid Password. Password is nil'			
			#redirect_to 'login' and return
		end

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
		  redirect_to '/kuniri' and return
    else
    	flash.now[:error] = 'Invalid email/password combination'
      redirect_to 'login' and return
    end


  end
  
end
