#!/usr/bin/ruby

require 'json'
require 'set'


if ARGV.size < 2
  $stderr.puts 'Please specify both a qrels file and a data pool directory.'
  exit
end

qfile = ARGV[0]
pooldir = ARGV[1]

ids = Set.new
File.open(qfile, 'r').each_line do |line|
  id = line.split()[2].to_i
  ids.add(id)
end

subdir = Dir["#{pooldir}/**/**"]
subdir.each do |f|
  unless File.directory?(f)
    File.open(f).each_line do |line|
      j = JSON.parse(line)
      if ids.include?(j['id'])
        puts line
      end
    end
  end
end
