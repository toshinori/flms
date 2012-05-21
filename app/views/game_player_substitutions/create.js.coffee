$('#<%= Constants.input_dialog_id %>').modal('hide')
<% data_game_team_id = "[data-game-team-id=#{@game_team.id}]" %>
<% selector = "#substitutions #{data_game_team_id}" %>
<% locals = {game_team: @game_team} %>
<% html = j render partial: 'shared/substitution_list', locals: locals %>
<% logger.info(html) %>
$("<%= selector %>").html("<%= html %>")
