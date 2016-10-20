class TokenController < ApplicationController

	def index
		@tokens = current_user.tokens
	end

	def create
		token = Saltedge::Client.new.create_token(token_params)
		token["salt_id"] = current_user.salt_id
		Token.create(token)
		redirect_to token["connect_url"]
	end

	def token_params
		{
			customer_id: current_user.salt_id,
		}
	end
end
