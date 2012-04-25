class AddDeletedAtToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :deleted_at, :timestamp
  end
end
