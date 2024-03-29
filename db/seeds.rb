# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Constants.positions.each do |name|
  Position.find_or_create_by_name(name)
end

#TODO sqlite専用処理のため他のDBにした場合は変更が必要
Foul.delete_all
Foul.connection.execute("delete from sqlite_sequence where name = 'fouls'")

Constants.foul.map{|foul| foul.symbolize_keys }.each do |foul|
  Foul.find_or_create_by_symbol(foul[:symbol]) do |f|
    f.foul_type = foul[:foul_type]
  end

  Foul.find_by_symbol(foul[:symbol]) do |f|
    f.foul_type = foul[:foul_type]
    f.save
  end
end

