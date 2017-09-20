Rails.application.routes.draw do

	namespace :api do
		namespace :v1 do
			resources :users
			post '/login', to: 'auth#create'
			# get '/', to: 'flights#index'
			# get '/flights', to: 'flights#show'

		end
	end
end
