class AddColumnsToGameMembers < ActiveRecord::Migration
  def change
    # change_table :game_members do |t|
      # t.string, :first_name
      # t.string, :last_name
      # t.integer, :uniform_number
    # end
    add_column :game_members, :first_name, :string
    add_column :game_members, :last_name, :string

    add_column :game_members, :uniform_number, :integer
  end

end
