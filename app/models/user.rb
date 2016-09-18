class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many 		 :logins, primary_key: :salt_id, foreign_key: :customer_id, dependent: :destroy
  has_many     :accounts, through: :logins
  after_create :create_customer

private

  def create_customer
  	customer = Saltedge::Client.new.create_customer(email)
  	self.update_attributes(salt_id: customer["id"], salt_secret: customer["secret"])
  end
end
