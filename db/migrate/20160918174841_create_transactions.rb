class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
    	t.integer :salt_id, unique: true, index: true
    	t.boolean :duplicated
    	t.string :mode
    	t.string :status
    	t.datetime :made_on
    	t.decimal :amount
    	t.string :currency_code
    	t.string :description
    	t.string :category
    	t.text :extra
    	t.integer :account_id, index: true
    	t.datetime :created_at
    	t.datetime :updated_at
    end
  end
end
