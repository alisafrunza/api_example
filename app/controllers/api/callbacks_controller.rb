class Api::CallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_filter :authenticate_user!

  def success
    puts params

    login_hash = Saltedge::Client.new.show_login(params[:data][:login_id])

    puts login_hash

    login_hash["salt_id"] = login_hash.delete("id")
    login = Login.find_or_create_by(salt_id: login_hash["salt_id"])
    login.update_attributes(login_hash)

    accounts = Saltedge::Client.new.get_accounts(login)
    save_fresh_accounts(accounts)

    transactions = Saltedge::Client.new.get_transactions(login)
    save_fresh_transactions(transactions)

    render :nothing => true
  end

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

  def fail
    puts params

    if params[:data][:error_class] == "InvalidCredentials"

      100.times { puts "IT WORKS"}
      login_hash = Saltedge::Client.new.show_login(params[:data][:login_id])
      puts "BEFORE LOGIN_HASH"
      puts login_hash

      login_hash["salt_id"] = login_hash.delete("id")
      login = Login.find_or_create_by(salt_id: login_hash["salt_id"])
      login.update_attributes(login_hash)

      render :nothing => true
    end
  end
end