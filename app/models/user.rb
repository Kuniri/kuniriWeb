class User < ActiveRecord::Base

	#uses the bcrypt algorithm to securely hash a user's password
	def has_secure_password
	end

end
