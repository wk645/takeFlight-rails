Rails.application.routes.draw do

	namespace :api do
		namespace :v1 do
			resources :users, only: [:create, :show]
			post '/login', to: 'auth#create'
			get '/flight', to: 'flights#index'
			get '/flight/:id', to: 'flights#show'
			post '/flight', to: 'flights#create'
			post '/add_flight', to: 'users#add_flight'
			delete '/delete_flight', to: 'saved_flights#destroy'
			get '/my_flights', to: 'users#my_flights'
			post 'add_picture', to: 'users#add_picture'
		end
	end
end

