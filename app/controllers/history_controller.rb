class HistoryController < ApplicationController

	def show
		query = "user_id=#{current_user.id}"
		@projects = Project.where(query)
	end

end
