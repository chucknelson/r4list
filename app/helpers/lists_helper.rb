module ListsHelper

	def list_items_remaining_description(list)
		if list.completed?
			'No items'
		else
			pluralize(list.items_remaining, 'item') + ' remaining'
		end
	end

end
