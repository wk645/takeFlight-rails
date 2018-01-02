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
        'Authorization' => 'Bearer T1RLAQLb3i4GYuElES1BXeV4/D7CicZsURBbdbKcQdvYrObhnJxhHb4/AADASgbOtysy//MQHTbAHfnPa+NCZVJXfBX61LJXP6wEzVttkJvaDegOk01Tsu/Vn/GW+YFSpUE3AzfPhPUCu8kg7cokIC9LhUMG9JLr45d12EyatI8XbGFEKF2iQA1zG1v3fUAwzes0AeQ/A3jL7xjNVncWirIBaBL+kE2DUKFsGevVeDT9LTMNvB9P0pFppsEkEtpxozM++6E+JWhtGItr0QIUC+/euzT2a/t8gPPR/xx5lHk+3dp4mli1yz8ePr+u'}
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