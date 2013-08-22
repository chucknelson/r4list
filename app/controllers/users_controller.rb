class UsersController < ApplicationController
	before_action :authenticate_admin, :except => [:new, :create] #helper method(s) in application controller

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
		@stumpers = stumpers
	end

	def create
		@user = User.new(user_params)

		if create_stumper_valid? and @user.save
			redirect_to login_path, notice: 'User created! Time to login and make some lists!'
		else
			@stumpers = stumpers
			render 'new'
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy

		redirect_to users_path
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		def stumpers
			[Random.rand(10), Random.rand(10)]
		end

		def create_stumper_valid?
			if params[:stumper].to_i == (params[:stumper_first].to_i + params[:stumper_second].to_i)
				return true
			else
				@user.errors.add(:humanity_test, 'answer is incorrect')
				return false
			end
		end	
end
