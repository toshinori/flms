<% data_game_team_id = "[data-game-team-id=#{@game_team.id}]" %>
<% selector = "#substitutions #{data_game_team_id}" %>
<% locals = {game_team: @game_team} %>
<% html = j render partial: 'shared/substitution_list', locals: locals %>
$("<%= selector %>").html("<%= html %>")
