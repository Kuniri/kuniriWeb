class AnalyseCodeController < ApplicationController
	before_action :require_user, only: [:index, :show]
	
	def new
		@project = Project.new
	end

	def create
		@project = Project.new(project_param)
		@project.name = extract_name_project(@project.link)
		@project.user_id = current_user.id

		if @project.save
			flash[:notice] = "project analysed with success. user id: #{@project.user_id}"
			redirect_to '/kuniri' and return
		else
			redirect_to '/analyse_code' and return
		end
	end

	def analyse_code
	end

def extract_name_project(link)
	name = /https:\/\/github.com\/(\w*)\/(\w*)/.match(link)
	name[2]
end

	private

		def project_param
			params.require(:project).permit(:name,:link,:user_id)
		end

end
