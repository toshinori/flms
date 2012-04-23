class CreateGameTeams < ActiveRecord::Migration
  def change
    create_table :game_teams do |t|
      t.integer :team_id
      t.integer :home_or_away

      t.timestamps
    end
  end
end
