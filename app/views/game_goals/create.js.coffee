$('#<%= Constants.input_dialog_id %>').modal('hide')
<% data_game_team_id = "[data-game-team-id=#{@game_team.id}]" %>
<% selector = "#goals #{data_game_team_id}" %>
<% locals = {game_team: @game_team} %>
<% html = j render partial: 'shared/goal_list', locals: locals %>
$("<%= selector %>").html("<%= html %>")
