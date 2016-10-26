class ListsController < ApplicationController
	before_action :authenticate_user # helper method(s) in application controller

	# Lists are nested resources of users, which is why each action creates the user model
	# All of the resource paths expect a user and a list model

	def index
		params[:user_id] ||= current_user.id # for lists_path
		@user = User.find(params[:user_id])
		@lists = @user.lists.order(items_remaining: :desc, updated_at: :desc)
		# TODO: Add "completed" to list DB record for efficient sorting
		# TODO: Change item "after_save" method to a more general "update_parent_list" method (it should remain small)
	end

	def show
		@user = User.find(params[:user_id])
		@list = @user.lists.find(params[:id])
		@items = @list.items.order(:sort_order, :id) # default sort

		@item_focus = params[:item_focus]
	end

	def new
		@user = User.find(params[:user_id])
		@list = @user.lists.build
	end

	def create
		@user = User.find(params[:user_id])
		@list = @user.lists.create(list_params)

		if @list.save
			redirect_to user_list_path(@user, @list), notice: 'List created successfully'
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

	def sort
		@user = User.find(params[:user_id])
		@list = @user.lists.find(params[:list_id])
		@item_sort = params[:sort]

		#update item sort_order if changed
		@list.items.each do |item|					
			new_sort_order = @item_sort[item.id.to_s].to_i #is there a way to avoid all of this type conversion?	
			#only update if changed
			if item.sort_order != new_sort_order
				item.update(:sort_order => new_sort_order)
			end
		end

		respond_to do |format|
			format.js { }
		end
	end

	private
		def list_params
			params.require(:list).permit(:title)
		end

end

