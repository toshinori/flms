class AddDeletedAtToMembers < ActiveRecord::Migration
  def change
    add_column :members, :deleted_at, :timestamp
    # add_column :members, :deleted_at, :boolean, null: false, default: false
  end
end
