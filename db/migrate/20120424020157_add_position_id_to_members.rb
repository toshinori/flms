class AddPositionIdToMembers < ActiveRecord::Migration
  def change
    add_column :members, :position_id, :integer
  end
end
