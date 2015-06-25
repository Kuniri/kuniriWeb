require 'kuniri/core/kuniri'
require 'kuniri/parser/parser_xml'

class AnalyseCodeController < ApplicationController
	before_action :require_user, only: [:index, :show]

	def new
		@project = Project.new
	end

	def create
		@project = Project.new(project_param)
		@project.name = extract_name_project
		@project.user_id = current_user.id

		if @project.name != nil
			analyse_code

			if @project.save
				redirect_to "/analyse_code?project_name=#{@project.name}" and return
			else
				flash[:notice] = "Project can not be analysed."
			end
		end
		flash[:notice] = "Project link do not exist!"

		redirect_to '/analyse_code' and return
	end

	def analyse_code
		create_local_repo
		clone_repo_from_link
		run_kuniri
		delete_projects
	end

	private

		def project_param
			params.require(:project).permit(:name,:link,:user_id)
		end

		def extract_name_project
			if @project.link != ""
				name = /https:\/\/github.com\/(\w*)\/(\w*)/.match(@project.link)
				name[2]
			end
		end

		def create_local_repo
			system("mkdir projects")
		end

		def clone_repo_from_link
			config_path = "projects/#{current_user.id}/#{@project.name}"
			cmd_clone = "git clone #{@project.link} #{config_path}"
			system(cmd_clone)
		end

		def run_kuniri
			output_xml_path = create_output_xml_path

			create_local_config

			kuniri = Kuniri::Kuniri.new("config_path/.kuniri")
			kuniri.run_analysis
	 		parser = Parser::XML.new
			parser.set_path(output_xml_path)
	 		parser.create_all_data kuniri.get_parser()
	
			flash[:notice] = "Project analysed with success!"
		end

		def create_output_xml_path
			system("mkdir public/#{current_user.id}")
			system("mkdir public/#{current_user.id}/#{@project.name}")
			"public/#{current_user.id}/#{@project.name}/class_data.xml"
		end

		def create_local_config

			config_path = "projects/#{current_user.id}/#{@project.name}"
			system("mkdir #{config_path}/output")
			File.open("#{config_path}/.kuniri", "w+") do |file|

		  	file.write("language:ruby\n")
		  	file.write("source:./\n")
		  	file.write("output:output/\n") #isso gera uma porrada de arquivos
		  	file.write("extract:xml\n")
			end
		end

		def delete_projects
			system("rm -rf projects/#{current_user.id}/*")
		end
end
