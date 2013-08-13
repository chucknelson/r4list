$('#new-item-placeholder').html('<a id="new-item-done-link" href="#">Done</a>')
$('ul#list-items').append("<%=j render 'items/form' %>")