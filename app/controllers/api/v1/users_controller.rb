class Api::V1::UsersController < ApplicationController

	before_action :authorized, only: [:show]

	def create
		@user = User.new(fullname: params[:fullname], email: params[:email], username: params[:username], password: params[:password])
		if @user.save
			payload = { user_id: @user.id }
			render json: { user: @user, jwt: issue_token(payload), success: "Welcome to takeFlight #{@user.username}!" }
		else
			render json: {message: "Invalid credentials"}
		end
	end

	def show
		render json: { user: current_user, flights: current_user.flights }
	end

	def my_flights
		render json: { flights: current_user.flights, user: current_user }
	end

	def add_flight
    user = current_user
    flight = Flight.find_by(id: params[:flight])
    
    flightObject = {user: user, 
                    flights: user.flights}

	    if !user.flights.include?(flight)
	    	user.flights << flight
	    end

  	render json: flightObject

  end

end

