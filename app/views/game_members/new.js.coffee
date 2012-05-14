<% @html = j render(partial: 'form')  %>
$('.modal-body').html("<%= @html %>")
$('#inputModal').modal('show')

