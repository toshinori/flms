$('#<%= Constants.input_dialog_id %>').modal('hide')
<% data_home_or_away = "[data-home-or-away=#{@game_team.home_or_away}]" %>
<% data_starting_status = "[data-starting-status=#{@starting_status}]" %>
<% selector = "#{data_home_or_away}#{data_starting_status}" %>
<% locals = {game_team: @game_team, starting_status: @starting_status} %>
<% html = j render partial: 'shared/player_list', locals: locals %>
$("<%= selector %>").html("<%= html %>")
