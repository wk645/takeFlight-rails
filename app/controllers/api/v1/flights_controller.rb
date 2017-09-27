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
        'Authorization' => 'Bearer T1RLAQKMe3Nx1UJcTV2OsvFrwmELQPahDhDFDRuBiB+ChWMBGTvU65IQAADAN+B0gHAZ8E1RlFDyL/Y8gtjCJAEGQraKxy193Hu9/UyBZhTBR7DAVZKuLkvle9YV4OW6US6DvehbJfpHd4n9ovup2edPMd4y4JBHZt9/oAFknNfihTU7yh2z8NuGlm67gsvMbbIrSkHHRdAWPNlveSLQ1t0qYXQXQzZBBSRra5j/zcz6r4N6ddX4r9ne9Yxah/h3LGdCsMceejv8T+h690g8PNLpNMcMdSV6L5VHYwBJY3g24JUC0cNORQYUsoe7'}
        # byebug
		@flight = JSON.parse(RestClient.get(url, headers))["FareInfo"]
		@savedFlights = @flight.map do |f|
			Flight.create(
				rank: f["DestinationRank"],
				destination: f["DestinationLocation"],
				airline: f["LowestFare"]["AirlineCodes"][0],
				departureDateTime: f["DepartureDateTime"],
				returnDateTime: f["ReturnDateTime"],
				fare: f["LowestFare"]["Fare"]
			)
		end
		# byebug
		render json: @savedFlights
	end

end

# https://api.test.sabre.com/v2/shop/flights/fares?origin=${from}&departuredate=${departDate}&returndate=${returnDate}&theme=${theme.toUpperCase()}&maxfare=${budget}&topdestinations=${top}