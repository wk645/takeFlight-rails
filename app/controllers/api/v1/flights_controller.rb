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
        'Authorization' => 'Bearer T1RLAQLuDBc0Gcs5i2TPIk/HgD9fAEPEwRBFqAj6mhNpdDSrJpinqAPzAADAYR7hxC3aT4fySL+ot3g7JxRdYvFKXGdQsexGxY/DNOlLqe21VS2h48S3LsX06menRjtYcbDmdEC33+UeCx9sU0c6CCqPgzL+6hxC9qYE/sNtVLqI/EUQ+EBi64FDD7/NbA/5zHRSJW6+TaSiIQUx09kgeeRGUWJn/wt7OPYuJ/Hu7x/V9VVqa/may4no5FSIgb7WNJ8vNHaHXJ2NHkSz2SwnpLCp7b7wVE03h4v7mfmIj2dqnbnia/Pj78+W4/JR'}
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
		render json: @savedFlights
	end

end