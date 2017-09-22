Rails.application.routes.draw do

	namespace :api do
		namespace :v1 do
			resources :users, only: [:create, :show]
			post '/login', to: 'auth#create'
			get '/flight', to: 'flights#index'
			get '/flight/:id', to: 'flights#show'
			post '/flight', to: 'flights#create'
			# get '/', to: 'flights#index'
			# get '/flights', to: 'flights#show'
		end
	end
end
