class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
    	t.integer :salt_id, unique: true, index: true
    	t.string :token
    	t.text :connect_url
    	t.datetime :expires_at
    	t.datetime :created_at
      t.datetime :updated_at

			t.integer :customer_id, index: true
    end
  end
end
