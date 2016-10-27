class LoginController < ApplicationController

  def index
    if params[:login_id]
      login_hash = Saltedge::Client.new.show_login(params[:login_id])
      login_hash["salt_id"] = login_hash.delete("id")
      login = Login.find_or_create_by(salt_id: login_hash["salt_id"])
      login.update_attributes(login_hash)
    end

    @logins = current_user.logins
    puts @logins
  end

  def show
    @accounts = current_login.accounts
  end

  def create_token
    token = Saltedge::Client.new.create_token(token_params)
    redirect_to token["connect_url"]
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

  def refresh_accounts
    accounts = Saltedge::Client.new.get_accounts(current_login)
    save_fresh_accounts(accounts)
    transactions = Saltedge::Client.new.get_transactions(current_login)
    save_fresh_transactions(transactions)
    redirect_to login_index_path
  end


private
  def save_fresh_accounts(accounts)
    accounts.each do |account|
      account["salt_id"] = account.delete("id")
      db_account = Account.find_or_create_by(salt_id: account["salt_id"])
      db_account.update_attributes(account)
    end
  end

  def save_fresh_transactions(transactions)
    transactions.each do |transaction|
      transaction["salt_id"] = transaction.delete("id")
      db_transaction = Transaction.find_or_create_by(salt_id: transaction["salt_id"])
      db_transaction.update_attributes(transaction)
    end
  end

  def current_login
    @current_login ||= current_user.logins.find(params[:id])
  end

  def login_params
    {
      customer_id: current_user.salt_id,
      username: params["username"],
      password: params["password"],
      provider_code: params["provider_code"],
      country_code: params["country_code"]
    }
  end

  def token_params
    {
      customer_id: current_user.salt_id,
      return_login_id: true
    }
  end
end