class DropGameProgresses < ActiveRecord::Migration
  def change
    drop_table :game_progresses
  end
end
