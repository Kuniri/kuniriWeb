class AnalyseCodeController < ApplicationController
	before_action :require_user, only: [:index, :show]
	
	def new
		@project = Project.new
	end

	def create
		@project = Project.new(project_param)
		@project.name = extract_name_project
		@project.user_id = current_user.id

		analyse_code

		if @project.save
			#flash[:notice] = "project submited with success."
			redirect_to '/kuniri' and return
		else
			redirect_to '/analyse_code' and return
		end
	end

	def analyse_code
		create_local_repo
		clone_repo_from_link
		run_kuniry
	end

	private

		def project_param
			params.require(:project).permit(:name,:link,:user_id)
		end

		def extract_name_project
			name = /https:\/\/github.com\/(\w*)\/(\w*)/.match(@project.link)
			name[2]
		end

		def create_local_repo
			system("mkdir projects")
		end

		def clone_repo_from_link
			cmd_clone = "git clone #{@project.link} projects/#{@project.name}"
			system(cmd_clone)
		end

		def run_kuniry
			flash[:notice] = "Project analysed with success!"
		end
end
