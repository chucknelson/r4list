# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#custom item events because :remote => true in rails causes the address bar show up on iOS (annoying!)
jQuery ->
	$('#list-items').on('click', '.item-link', (event) ->
		event.preventDefault()

		$.ajax(
			url: $(this).data('ajax-route'),
			type: 'PATCH',
			dataType: 'script'
		)
	)