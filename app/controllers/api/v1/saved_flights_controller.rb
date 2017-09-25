class Api::V1::SavedFlightsController < ApplicationController

	def index

	end

	def show

	end

	def destroy
		user = current_user
		flight = Flight.find_by(id: params[:flight])
		savedFlight = UserFlight.find_by(user: user, flight: flight)
		savedFlight.destroy
	end




end