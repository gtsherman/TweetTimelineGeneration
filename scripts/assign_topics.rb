#!/usr/bin/ruby

# Use this script to assign topics to users.
# Params:
#	1. A list of topic IDs, one for each relevant document for that query.
#		e.g. the output of grep -v 0$ qrels/qrels-mb15.txt | cut -d ' ' -f 1 
#	2. Number of judges
require 'pp'


counts = {}
File.open(ARGV[0]).each_line do |line|
  q = line.split()[0]
  counts[q] ||= 0
  counts[q] += 1
end
total = counts.values.inject(:+)

num_judges = ARGV[1].to_i
judge_counts = {}
assignments = {}
for i in 1..num_judges
  judge_counts[i] = 0
  assignments[i] = []
end

puts "Ideal max: #{total/judge_counts.size.to_f}"
while counts.size > 0
  judge = judge_counts.key(judge_counts.values.min)
  topic_size = counts.values.max
  topic = counts.key(topic_size)

  judge_counts[judge] += topic_size  # update judge's total assigned tweets
  assignments[judge].push(topic)  # update judge's assigned topics

  counts.delete(topic)  # remove topic now that it has been assigned
end

puts "\nNumber of tweets per judge:"
pp(judge_counts)      
puts "\nAssigned topics per judge:"
assignments.each do |j, a|
  puts "#{j}: #{a.join(', ')}"
end
