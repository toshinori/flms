class RemoveColumnsFromGames < ActiveRecord::Migration
  def up
    remove_column :games, :home_team_id
    remove_column :games, :away_team_id
  end

  def down
    add_column :games, :home_team_id, :integer
    add_column :games, :home_team_id, :integer
  end
end
