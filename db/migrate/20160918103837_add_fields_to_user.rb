class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :salt_id, :integer
    add_column :users, :salt_secret, :string

    add_index :users, :salt_id, unique: true
  end
end
