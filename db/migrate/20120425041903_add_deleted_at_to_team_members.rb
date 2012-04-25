class AddDeletedAtToTeamMembers < ActiveRecord::Migration
  def change
    add_column :team_members, :deleted_at, :timestamp
  end
end
