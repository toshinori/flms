class AddPositionIdToGameMember < ActiveRecord::Migration
  def change
    add_column :game_members, :position_id, :integer
  end
end
