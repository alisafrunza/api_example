class CallbacksController < ApplicationController
	skip_before_action :verify_authenticity_token

	def success
		pp params
		#pseudo
		#login exists fetch login compair attributes
		#login doesn't exist, create login
	end

	def fail
		pp params
	end
end