class CreateGameProgresses < ActiveRecord::Migration
  def change
    create_table :game_progresses do |t|
      t.integer :game_id, null: false
      t.integer :team_id, null: false
      t.integer :member_id,  null: false
      t.integer :half, null: false, default: 0
      t.timestamps
    end
  end
end
