class LoginController < ApplicationController

	def index
		@logins = current_user.logins
	end

	def new
	end

	def create
		login = Saltedge::Client.new.create_login(login_params)
		login["salt_id"] = login.delete("id")
		Login.create(login)
		redirect_to login_index_path
	end

	def update
		fresh_login = Saltedge::Client.new.refresh_login(current_login)
		fresh_login["salt_id"] = fresh_login.delete("id")
		current_login.update_attributes(fresh_login)
		redirect_to login_index_path
	end

	def destroy
		Saltedge::Client.new.destroy_login(current_login)
		current_login.delete
		redirect_to login_index_path
	end

private

	def current_login
		@login ||= current_user.logins.find(params[:id])
	end

	def login_params
		{
			customer_id: current_user.salt_id,
			username: params["username"],
			password: params["password"]
		}
	end
end