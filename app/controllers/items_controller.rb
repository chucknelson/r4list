class ItemsController < ApplicationController
	before_action :authenticate_user

	#items are nested resources of lists, which are nestes resources of users

	def new
		@user = User.find(params[:user_id])
		@list = @user.lists.find(params[:list_id])
		
		respond_to do |format|
			format.html {redirect_to user_list_path(@user, @list) }
			format.js { } #js response does the work
		end
	end


	def create
		@user = User.find(params[:user_id])
		@list = @user.lists.find(params[:list_id])
		@item = @list.items.create(item_params)

		redirect_to user_list_path(@user, @list, :item_focus => true)
	end

	def update
		@user = User.find(params[:user_id])
		@list = @user.lists.find(params[:list_id])
		@item = @list.items.find(params[:id])

		respond_to do |format|
			if @item.update(item_params)
				format.html {redirect_to user_list_path(@user, @list) }
				format.js { } #js response does the work
			else
				redirect_to user_list_path(@user, @list), alert: 'Item failed to update'
			end
		end
	end

	def destroy
		@user = User.find(params[:user_id])
		@list = @user.lists.find(params[:list_id])
		@item = @list.items.find(params[:id])

		@item.destroy

		redirect_to user_list_path(@user, @list), notice: 'Item deleted'
	end

	private
		def item_params
			params.require(:item).permit(:name, :completed)
		end
end
