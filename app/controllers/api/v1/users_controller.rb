class Api::V1::UsersController < ApplicationController

	before_action :authorized, only: [:show]

	def index
		@users = User.all
		render json: @users
	end

	def create
		@user = User.new(username: params[:username], password: params[:password])
		if @user.save
			payload = { user_id: @user.id }
			render json: { user: @user, jwt: issue_token(payload), success: "Welcome to takeFlight #{@user.username}!" }
		else
			render json: {message: "Invalid credentials!"}
		end
	end

	def show
		render json: { user: current_user }
	end

end