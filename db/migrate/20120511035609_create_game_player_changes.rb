class CreateGamePlayerChanges < ActiveRecord::Migration
  def change
    create_table :game_player_changes do |t|
      t.integer :game_member_id
      t.integer :occurrence_time
      t.integer :in_or_out

      t.timestamps
    end
  end
end
