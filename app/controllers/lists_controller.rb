class ListsController < ApplicationController
	before_action :authenticate_user

	#lists are nested resources of users, which is why each action creates the user model
	#all of the resource paths expect a user and a list model

	def index
		params[:user_id] ||= current_user.id #for lists_path
		@user = User.find(params[:user_id])
		@lists = @user.lists
	end

	def show
		@user = User.find(params[:user_id])
		@list = @user.lists.find(params[:id])
	end

	def new
		@user = User.find(params[:user_id])
		@list = @user.lists.build
	end

	def create
		@user = User.find(params[:user_id])
		@list = @user.lists.create(list_params)

		if @list.save
			redirect_to user_lists_path(@user), notice: 'List created successfully'
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:user_id])
		@list = @user.lists.find(params[:id])
	end

	def update
		@user = User.find(params[:user_id])
		@list = @user.lists.find(params[:id])

		if @list.update(list_params)
			redirect_to user_list_path(@user, @list), notice: 'List updated successfully'
		else
			render 'edit'
		end
	end

	def destroy
		@user = User.find(params[:user_id])
		@list = @user.lists.find(params[:id])
		
		if @list.destroy
			redirect_to user_lists_path(@user), notice: 'List deleted successfully'
		else
			render 'show'
		end
	end

	def complete_all
		@user = User.find(params[:user_id])
		@list = @user.lists.find(params[:list_id])

		@list.items.update_all(:completed => true) #uh, this doesn't validate - bad?

		redirect_to user_list_path(@user, @list)
	end

	def authenticate_user
		if !logged_in?
			redirect_to login_path, alert: 'You must be signed in to access your lists'
		elsif params[:user_id] && params[:user_id].to_i != current_user.id
			redirect_to user_lists_path(current_user), alert: 'You can only access lists that belong to you'
		end
	end

	private
		def list_params
			params.require(:list).permit(:title, :description)
		end

end

