class ChangeMemberType < ActiveRecord::Migration
  def up
    Member.where({ member_type: nil }).update_all({ member_type: 0 })
    change_column :members, :member_type, :integer, { null: false, default: 0 }
  end

  def down
    change_column :members, :member_type, :integer, { null: true }
  end
end
