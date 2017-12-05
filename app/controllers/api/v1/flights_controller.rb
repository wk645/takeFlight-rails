require 'rest-client'
require 'json'

class Api::V1::FlightsController < ApplicationController

	def index
		flights = Flight.all
		render json: flights
	end

	def create
		
		flightparams = "https://api.test.sabre.com/v2/shop/flights/fares?origin=#{params[:origin]}&departuredate=#{params[:departuredate].split("T")[0]}&returndate=#{params[:returndate].split("T")[0]}&theme=#{params[:theme]}&maxfare=#{params[:maxfare]}&topdestinations=#{params[:topdestinations]}"
		fetchFlight(flightparams)
	end

	def fetchFlight(url)
		headers = {
        'Authorization' => 'Bearer T1RLAQLcRK9DlILFiGCU44G0IBpaco3glxCzb0i4o1mvzfenukVcXMIyAADANCmsrfO/Gc8snNSjM4jFqHGX6LWjdXgGKFHZ3kGYtBXyrZpX6bON/2gik81+iccYDlyVzZGkjzXuxsfKDMPCvhIftTMeHXdgsE4ncTV+T27zA8CAEDU4VIgIYBI+14vMTO5pn5eVlVL+sJQDlpHBRyfJIh5N9DBq13adkRseH2SWpAhs2sFBO8qQFdUvWMtkOwdS0tcelwBnitm+LWewi6oBv2Ss6QpnJ/OR61oUu/YGo1Sp3WmqJ6IaFqHrvYMx'}
     	response = JSON.parse(RestClient.get(url, headers))
     	@origin = response["OriginLocation"]
		@flight = response["FareInfo"]
		@savedFlights = @flight.map do |f|
			Flight.create(
				rank: f["DestinationRank"],
				origin: @origin,
				destination: f["DestinationLocation"],
				airline: f["LowestFare"]["AirlineCodes"][0],
				departureDateTime: f["DepartureDateTime"],
				returnDateTime: f["ReturnDateTime"],
				fare: f["LowestFare"]["Fare"]
			)
		end
		# debugger
		render json: @savedFlights
	end

end