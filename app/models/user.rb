class User < ActiveRecord::Base
	has_many :projects
#	attr_reader :id, :first_name, :email, :last_name, :password_digest, :password_confirmation
	
	#uses the bcrypt algorithm to securely hash a user's password

  has_secure_password



end