# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#custom item events because :remote => true in rails causes the address bar show up on iOS (annoying!)
#delegate event binding, do not need $() / ready event binding, can break with turbolinks anyway
$(document).on('click', 'ul#list-items .item-link', (event) ->
	event.preventDefault()

	#flip first, THEN do network activity, response is priority
	animationTarget = $(this).parent();
	animationTarget.addClass('animated')
	animationTarget.toggleClass('flipped')

	$.ajax(
		url: $(this).attr('data-ajax-route'), #items/update
		type: 'PATCH',
		dataType: 'script'
	)
	.done( ->
		#alert('ajax done!')
	)
	.fail( ->
		#alert('ajax failed!')
	)
)

$(document).on('click', 'ul#list-items .item-edit-link', (event) ->
	event.preventDefault()

)

$(document).on('click', 'ul#list-items .item-edit-container input[type=submit]', (event) ->
	event.preventDefault()
)

#having a webkit transition property on an element causes sorting behavior to go wacky (draggable item sizes weird)
#to get around that, I'm adding and removing the webkit transition behavior via events
#when a user tries to sort, the transition property isn't there, so nothing is messed up
$(document).on('webkitTransitionEnd', 'ul#list-items li', (event) ->
	$(this).removeClass('animated')
)

