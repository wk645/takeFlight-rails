class User < ApplicationRecord
	has_secure_password
	has_many :user_flights
	has_many :flights, through: :user_flights

	validates :username, :email, uniqueness: true
	
end