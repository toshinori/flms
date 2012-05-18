class RenameGamePlayerChangesToGamePlayerSubstitutions < ActiveRecord::Migration
  def change
    rename_table :game_player_changes, :game_player_substitutions
  end
end
