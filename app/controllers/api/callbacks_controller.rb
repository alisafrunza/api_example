class CallbacksController < ApplicationController
	skip_before_action :verify_authenticity_token

	def success
		pp params

		login_hash = Saltedge::Client.new.show_login(params[:login_id])
		login_hash["salt_id"] = login_hash.delete("id")
		login = Login.find_or_create_by(salt_id: login_hash["salt_id"])
		login.update_attributes(login_hash)

		accounts = Saltedge::Client.new.get_accounts(current_login)
		save_fresh_accounts(accounts)
		transactions = Saltedge::Client.new.get_transactions(current_login)
		save_fresh_transactions(transactions)

		render :nothing => true
		#pseudo
		#login exists fetch login compair attributes
		#login doesn't exist, create login
	end

	def fail
		pp params
	end
end