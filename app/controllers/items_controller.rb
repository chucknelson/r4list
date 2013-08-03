class ItemsController < ApplicationController

	#items are nested resources of lists, which are nestes resources of users

	def create
		@user = User.find(params[:user_id])
		@list = @user.lists.find(params[:list_id])
		@item = @list.items.create(item_params)

		redirect_to user_list_path(@user, @list)
	end

	def update
		@user = User.find(params[:user_id])
		@list = @user.lists.find(params[:list_id])
		@item = @list.items.find(params[:id])

		if @item.update(item_params)
			redirect_to user_list_path(@user, @list)
		else
			redirect_to user_list_path(@user, @list), alert: 'Item failed to update'
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
