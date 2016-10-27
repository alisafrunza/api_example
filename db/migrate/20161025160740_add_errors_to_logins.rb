class AddErrorsToLogins < ActiveRecord::Migration
  def change
  	add_column :logins, :fail_error_class, :string
  	add_column :logins, :fail_message, :string
  end
end
