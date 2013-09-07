# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#TODO rollback any item change upon ajax failure, includes values, flip state, etc.

#wrapper class for items
class Item
	constructor: (@jqObject) ->
		@id = @jqObject.attr('data-item-id')
		@ajaxUpdateRoute = @jqObject.attr('data-ajax-update-route')
		@completedStatusSelector = '#item-' + @id + '-completed-status'
		@itemViewSelector = '.item-view'
		@itemNameSelector = '.item-view .item-link'
		@itemEditSelector = '.item-edit'
		@itemNameInputSelector = '.item-edit input[name="name"]'

	itemName: (name) ->
		if(name != undefined)
			@jqObject.find(@itemNameSelector).html(name)

		@jqObject.find(@itemNameSelector).html()

	itemNameInput: (name) ->
		if(name != undefined)
			@jqObject.find(@itemNameInputSelector).val(name)

		@jqObject.find(@itemNameInputSelector).val()

	completedStatus: (status) ->
		if(status != undefined)
			@jqObject.find(@completedStatusSelector).val(status)
		
		@jqObject.find(@completedStatusSelector).val() == 'true' #force return of boolean

	flip: ->
		@jqObject.addClass('animated')
		@jqObject.toggleClass('flipped')

	updateItemName: ->
		#update item name from input
		newItemName = @itemNameInput()
		@itemName(newItemName)

		#update item in db
		@update({ name: newItemName })

	revertItemName: ->
		#revert item name
		oldItemName = @itemName()
		@itemNameInput(oldItemName)

	toggleCompletedStatus: ->
		@completedStatus(!@completedStatus())
		@update({ completed: @completedStatus() })

	toggleEdit: ->
		#should I chain these together? No for now, just a style choice...
		@jqObject.toggleClass('no-sort')
		@jqObject.toggleClass('editing')
		@jqObject.find(@itemViewSelector).toggleClass('hidden')
		@jqObject.find(@itemEditSelector).toggleClass('hidden')

		if(@jqObject.find(@itemViewSelector).hasClass('hidden'))
			@jqObject.find(@itemNameInputSelector).focus()
			#@itemNameInput(@itemName()) 
		else
			@jqObject.find(@itemNameInputSelector).blur()

	update: (updateValues) ->
		$.ajax(
			url: @ajaxUpdateRoute, #items/update
			type: 'PATCH',
			dataType: 'script',
			data: { item: updateValues }
		)
		.done( ->
			#alert('ajax done!')
		)
		.fail( ->
			#alert('ajax failed!')
		)		

#get the parent item from wherever you are in item tree
parentItem = (jqObject) ->
	if(jqObject.is('li'))
		new Item jqObject
	else
		new Item jqObject.parents('li')

acceptItemEdit = (item) ->
	item.updateItemName()
	item.toggleEdit()

cancelItemEdit = (item) ->
	item.revertItemName()
	item.toggleEdit()

newItemToggle = ->
	$('#new-item-placeholder').toggleClass('hidden')
	$('#new-item').toggleClass('hidden')

#having a webkit transition property on an element causes sorting behavior to go wacky (draggable item sizes weird)
#to get around that, I'm adding and removing the webkit transition behavior via events
#when a user tries to sort, the transition property isn't there, so nothing is messed up
$(document).on('webkitTransitionEnd', 'ul#list-items li', (event) ->
	$(this).removeClass('animated')
)

#custom item events because :remote => true in rails causes the address bar show up on iOS (annoying!)
#delegate event binding, do not need $() / ready event binding, can break with turbolinks anyway
$(document).on('click', 'ul#list-items .item-link', (event) ->
	event.preventDefault()

	#flip first, THEN do network activity, response is priority
	targetItem = parentItem($(this))
	targetItem.flip()
	targetItem.toggleCompletedStatus()
)

$(document).on('click', 'ul#list-items .item-edit-link', (event) ->
	event.preventDefault()

	targetItem = parentItem($(this))
	targetItem.toggleEdit()
)

$(document).on('click', 'ul#list-items .item-edit-done', (event) ->
	event.preventDefault()

	targetItem = parentItem($(this))
	acceptItemEdit(targetItem)
)

$(document).on('click', 'ul#list-items .item-edit-cancel', (event) ->
	event.preventDefault()

	targetItem = parentItem($(this))
	cancelItemEdit(targetItem)
)

$(document).on('keyup', 'ul#list-items .item-edit input[type=text]', (event) ->
	event.preventDefault()
	if(event.keyCode == 13) #enter key, needed because this input is not in a form
		targetItem = parentItem($(this))
		acceptItemEdit(targetItem)

	else if(event.keyCode == 27) #escape key
		targetItem = parentItem($(this))
		cancelItemEdit(targetItem)
)

$(document).on('click', 'a.add-item-link', (event) ->
	event.preventDefault()
	newItemToggle()
	$('#new-item input[type=text]').focus()
)

$(document).on('click', '#new-item-cancel', (event) ->
	event.preventDefault()
	newItemToggle()
	$('#new-item input[type=text]').blur()
)

$(document).on('keyup', '#new-item input[type=text]', (event) ->
	event.preventDefault()
	#do not need to worry about enter key, this input is already in a form
	if(event.keyCode == 27) #escape key
		newItemToggle()
		$('#new-item input[type=text]').blur()
)
