class AddMemberTypeToMembers < ActiveRecord::Migration
  def change
    add_column :members, :member_type, :integer

  end
end
