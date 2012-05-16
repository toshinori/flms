<% @html = j render(partial: 'form')  %>
<% logger.debug @html %>
$('.modal-body').html("<%= @html %>")
$('#<%= Constants.input_dialog_id %>').modal('show')

