#not binding events or anything, so no jQuery -> wrapper needed (which is for the ready or page:load event)
#replace modified list item with updated content
#have to use .attr() here because .data() only works the first time you set HTML5 data-* tags
$('li[data-item-id="<%= @item.id %>"] .item-link').attr('data-ajax-route', '<%= user_list_item_path(@user, @list, @item, :item => { :completed => !@item.completed }) %>')