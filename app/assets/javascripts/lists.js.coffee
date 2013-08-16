# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

newItemToggle = ->
	$('#new-item-placeholder').toggleClass('hidden')
	$('#new-item').toggleClass('hidden')

$(document).on('click', '#new-item-placeholder a', (event) ->
	event.preventDefault()
	newItemToggle()
	$('#new-item input[type=text]').focus()
)

$(document).on('focusout', '#new-item input[type=text]', (event) ->
	newItemToggle()
)

jQuery ->
	$('#list-items').sortable(
		items: 'li:not(.nosort)'

		#defining the helper as a static li > table element works much better/easier than changing
		#the entire list structure, styling, and animation to work with li > table elements
		helper: ->
			'<li class="sorting-item">
				<table style="width: 100%; height: 100%;">
					<tr>
						<td style="width: 80%; height: 100%; vertical-align: middle" class="item-link">
							Helper Item Name
						</td>
						<td style="width: 20%; height: 100%; vertical-align: middle text-align: right;" class="item-delete-link">
							Helper Delete Link
						</td>
					</tr>
				</table>
			</li>'

		start: (event, ui) ->
			ui.item.addClass('sorting-item')
			ui.placeholder.height(ui.helper.height());
			ui.helper.find('.item-link').html(ui.item.find('.item-link').html())
			ui.helper.find('.item-delete-link').html(ui.item.find('.item-delete-link').html())

		stop: (event, ui) ->
			ui.item.removeClass('sorting-item')

		update: (event, ui) ->
			newSort = {}
			ui.item.parent().children().each( -> 
				itemID = $(this).attr('data-item-id')
				sortOrder = $(this).index()
				newSort[itemID] = sortOrder
			)

			$.ajax(
				url: ui.item.parent().attr('data-ajax-sort-route'),
				data: { sort: newSort },
				type: 'PATCH',
				dataType: 'script'
			)
		)