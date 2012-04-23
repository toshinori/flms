class AddGameTeamIdToGameMember < ActiveRecord::Migration
  def change
    change_table :game_members do |t|
      t.integer :game_team_id
      t.remove :game_id
      t.remove :team_id
    end
  end
end
