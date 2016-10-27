class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :logins, :error_class, :fail_error_class
  	rename_column :logins, :error_message, :fail_message
  end
end
