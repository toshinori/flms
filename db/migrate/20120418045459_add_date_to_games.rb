class AddDateToGames < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.date :the_date
      t.time :start_time
      t.time :end_time
    end
  end
end
