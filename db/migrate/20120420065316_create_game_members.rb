class CreateGameMembers < ActiveRecord::Migration
  def change
    create_table :game_members do |t|
      t.integer :game_id
      t.integer :team_id
      t.integer :member_id
      t.integer :starting_status
      t.timestamps
    end
  end
end
