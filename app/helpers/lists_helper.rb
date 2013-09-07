module ListsHelper

	def list_items_remaining_description(list)
		if list.items.empty?
			'No items'
		else
			pluralize(list.items_remaining, 'item') + ' remaining'
		end
	end

end
