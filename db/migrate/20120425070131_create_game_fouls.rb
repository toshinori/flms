class CreateGameFouls < ActiveRecord::Migration
  def change
    create_table :game_fouls do |t|
      t.integer :game_member_id
      t.integer :occurrence_time
      t.integer :foul_id

      t.timestamps
    end
  end
end
