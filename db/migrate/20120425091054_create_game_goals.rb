class CreateGameGoals < ActiveRecord::Migration
  def change
    create_table :game_goals do |t|
      t.integer :game_member_id
      t.integer :occurrence_time

      t.timestamps
    end
  end
end
