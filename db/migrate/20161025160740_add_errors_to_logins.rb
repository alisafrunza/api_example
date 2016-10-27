class AddErrorsToLogins < ActiveRecord::Migration
  def change
  	add_column :logins, :error_class, :string
  	add_column :logins, :error_message, :string
  end
end
