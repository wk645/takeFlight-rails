require 'rest-client'
require 'json'

class Api::V1::FlightsController < ApplicationController

	def index
		@flights = Flight.all
		render json: @flights
	end

	def create
		flightparams = "https://api.test.sabre.com/v2/shop/flights/fares?origin=#{params[:origin]}&departuredate=#{params[:departuredate]}&returndate=#{params[:returndate]}&theme=#{params[:theme]}&maxfare=#{params[:maxfare]}&topdestinations=#{params[:topdestinations]}"

		fetchFlight(flightparams)
	end

	def fetchFlight(url)
		headers = {
        'Authorization' => 'Bearer T1RLAQKQIxO4qNOeiFE/1zDC0BOqHkOETRArl1STWSnakRR6rK/zxZR2AADA5F2CtdzCu1ndeeA+8IZdNJgQwN0CpJ0Rr/du81G/s9BxJmOnRZlub8xq2CyKI34OeEtnhe0VCXzaMC2zOS6Haz+eV4eCKee23cumAOhOtLUQgJ0tiewNezsbk+MVXNXVXszGqqIQ73WhCJr71d37ryWH+5n18kQjOCdYXIQ1bh7gFeqlbsr9pyydAMYPejGSYdwJd778hHkoWWW1RuQyUmm/QCZCPHJHkNivt5exDZ/GOwz9GXsCc4tCW7501LmJ'}
        debugger
		@flight = JSON.parse(RestClient.get(url, headers))["FareInfo"]
		@flight.map do |f|
			@flight = Flight.create(
				rank: f["DestinationRank"],
				destination: f["DestinationLocation"],
				airline: f["LowestFare"]["AirlineCodes"].flatten,
				departureDateTime: f["DepartureDateTime"].split("T")[0],
				returnDateTime: f["ReturnDateTime"].split("T")[0],
				fare: f["LowestFare"]["Fare"]
			)
		end

		render json: @flight
	end

	# def show
	# 	@flight = JSON.parse(RestClient.get("https://api.test.sabre.com/v2/shop/flights/fares?origin=#{from}&departuredate=#{departDate}&returndate=#{returnDate}&theme=#{theme.toUpperCase()}&maxfare=#{budget}&topdestinations=#{top}"))["fareInfo"]
	# 	@flight.each do |f|
	# 		flight = Flight.create(
	# 			rank: f["DestinationRank"],
	# 			destination: f["DestinationLocation"],
	# 			airline: f["LowestFare"]["AirlineCodes"],
	# 			departureDateTime: f["DepartureDateTime"],
	# 			returnDateTime: f["ReturnDateTime"],
	# 			fare: f["LowestFare"]["Fare"]
	# 		)
	# 	end
	# 	render json: @flight
	# end


end

# https://api.test.sabre.com/v2/shop/flights/fares?origin=${from}&departuredate=${departDate}&returndate=${returnDate}&theme=${theme.toUpperCase()}&maxfare=${budget}&topdestinations=${top}