class AnalyseCodeController < ApplicationController
	before_action :require_user, only: [:index, :show]
	def analyse_code
	end
end
