<% @html = j render(partial: 'form')  %>
<% logger.info(@html) %>
$('.modal-body').html("<%= @html %>")
$('#<%= Constants.input_dialog_id %>').modal('show')
