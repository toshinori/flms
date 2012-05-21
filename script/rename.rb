#!/usr/bin/env ruby
# coding: utf-8

old = ARGV[0]
new = ARGV[1]

if old.blank? || new.blank?
  STDERR.puts "Usage: rails runner ./script/rename old new"
  exit 1
end

old = old.downcase
new = new.downcase
olds = old.pluralize
news = new.pluralize

def file_each(&block)
  Dir.glob('./**/*') do |file|
    next if file["script/"]
    next if file["Gemfile"] || file["Rakefile"] || file["Guardfile"] || file["config.ru"]
    next if file["vendor/"]
    next if file["config/"] && !file["routes.rb"]
    next if file["db/"]
    next if file["tmp/"] || file["log/"] || file["doc/"]
    next if file[".git/"]

    print "."
    yield file
  end
  puts
end

# ディレクトリ名を変更する
puts "ディレクトリ名を変更しています"
file_each do |file|
  next unless File.directory?(file)
  if file[olds]
    # 複数形を変更する
    File.rename(file, file.gsub(olds, news))
  elsif file[old]
    # 単数形を変更する
    File.rename(file, file.gsub(old, new))
  end
end

# ファイル名を変更する
puts "ファイル名を変更しています"
file_each do |file|
  next unless File.file?(file)
  if file[olds]
    # 複数形を変更する
    File.rename(file, file.gsub(olds, news))
  elsif file[old]
    # 単数形を変更する
    File.rename(file, file.gsub(old, new))
  end
end

# ファイルの中の文字列を変更する
puts "ファイルを変更しています"
file_each do |file|
  next unless (File.file?(file) && !File.extname(file).match(/\.(jpg|png|gif|ico)$/))
  # 複数形を変更する
  system %Q|sed -i s/#{olds}/#{news}/g #{file}|
  system %Q|sed -i s/#{olds.capitalize}/#{news.capitalize}/g #{file}|
  # 単数形を変更する
  system %Q|sed -i s/#{old}/#{new}/g #{file}|
  system %Q|sed -i s/#{old.capitalize}/#{new.capitalize}/g #{file}|
end
