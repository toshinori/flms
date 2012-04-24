# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Position::Positions.each do |name|
  Position.find_or_create_by_name(name)
end


Foul::FoulSeeds.each do |foul|
  Foul.find_or_create_by_symbol(foul[:symbol]) do |f|
    f.description = f[:description]
    f.foul_type = f[:foul_type]
  end
end

