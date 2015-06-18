class AnalyseCodeController < ApplicationController
	before_action :require_user, only: [:index, :show]
	
	def new
		@project = Project.new
	end

	def create
		@project = Project.new(project_param)

		if @project.save
			flash[:notice] = "project analysed with success. user id: #{current_user.id}"
			redirect_to '/kuniri' and return
		else
			redirect_to '/analyse_code' and return
		end
	end

	def analyse_code
	end

	private

		def project_param
			params.require(:project).permit(:link,current_user.id)
		end

end
