# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#NOTE - should this be how I bind events w/ turbolinks, or should I be doing something different?
jQuery ->
	$('#list-items').sortable(
		update: (event, ui) ->
			newSort = {}
			ui.item.parent().children().each( -> 
				itemID = $(this).data('item-id')
				sortOrder = $(this).index()
				newSort[itemID] = sortOrder
			)

			$.ajax(
				url: ui.item.parent().data('ajax-sort-route'),
				data: { sort: newSort },
				type: 'PATCH',
				dataType: 'script'
			)
		)