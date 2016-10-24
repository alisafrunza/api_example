class Account < ActiveRecord::Base
  has_many :salt_transactions, primary_key: :salt_id, dependent: :destroy, class_name: "Transaction"
  belongs_to :login, primary_key: :salt_id
end