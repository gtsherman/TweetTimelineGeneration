#!/usr/bin/ruby


if ARGV.size < 1
  $stderr.puts('Please specify a topics file.')
  exit
end

tfile = ARGV[0]

title = false
File.open(tfile).each_line do |line|
  if line =~ /^<num>/
    print(line.split()[-1]+"\t")
  elsif line =~ /^<title>/
    title = true
  elsif title
    puts(line)
    title = !title    
  end
end
  
