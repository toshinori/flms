class AddNameToGameTeams < ActiveRecord::Migration
  def change
    add_column :game_teams, :name, :string
  end
end
