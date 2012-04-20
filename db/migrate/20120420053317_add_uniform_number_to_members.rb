class AddUniformNumberToMembers < ActiveRecord::Migration
  def change
    add_column :members, :uniform_number, :integer

  end
end
