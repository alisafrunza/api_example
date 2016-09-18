class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :salt_id, unique: true, index: true
    	t.string :name
    	t.string :nature
    	t.decimal :balance
    	t.string :currency_code
    	t.text :extra
    	t.integer :login_id, index: true
    	t.datetime :created_at
    	t.datetime :updated_at
    end
  end
end
