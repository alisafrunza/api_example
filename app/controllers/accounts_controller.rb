class AccountsController < ApplicationController
  def show
    @transactions = current_account.salt_transactions
  end

private
  def current_account
    @current_account ||= current_user.accounts.find(params[:id])
  end
end