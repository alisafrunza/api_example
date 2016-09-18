class AddFieldsToLogin < ActiveRecord::Migration
  def change
  	add_column :logins, :secret, :string
  end
end
