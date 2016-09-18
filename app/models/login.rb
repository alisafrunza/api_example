class Login < ActiveRecord::Base
	has_many :accounts, primary_key: :salt_id, dependent: :destroy
end
