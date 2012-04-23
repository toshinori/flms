class AddGameIdToGameTeams < ActiveRecord::Migration
  def change
    add_column :game_teams, :game_id, :integer
  end
end
