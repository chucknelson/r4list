class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:email])

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to lists_path, notice: 'Successfully logged in'
		else
			flash.now.alert = 'Email or password are not correct'
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path, notice: 'Successfully logged out'
	end

end
