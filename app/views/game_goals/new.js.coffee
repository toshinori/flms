<% @html = j render(partial: 'form')  %>
$('.modal-body').html("<%= @html %>")
$('#<%= Constants.input_dialog_id %>').modal('show')
