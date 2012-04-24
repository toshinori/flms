class CreateFouls < ActiveRecord::Migration
  def change
    create_table :fouls do |t|
      t.string :symbol
      t.string :description
      t.integer :foul_type

      t.timestamps
    end
  end
end
