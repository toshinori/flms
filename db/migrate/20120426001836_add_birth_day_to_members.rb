class AddBirthDayToMembers < ActiveRecord::Migration
  def change
    add_column :members, :birth_day, :date

  end
end
