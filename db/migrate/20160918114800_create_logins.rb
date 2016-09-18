class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.string :country_code
      t.integer :salt_id, unique: true, index: true
			t.integer :provider_id
			t.string :provider_code
			t.string :provider_name
			t.string :status
			t.datetime :created_at
      t.datetime :updated_at
      t.datetime :last_success_at
			t.datetime :next_refresh_possible_at
			t.text :last_attempt
			t.text :holder_info
      t.boolean :daily_refresh

			t.integer :customer_id, index: true
    end
  end
end
