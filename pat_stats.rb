#!/usr/bin/ruby -w

# The MIT License (MIT)
# Copyright (c) 2016 Alexander J Probst

# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require "trollop"
require "nu"

opts=Trollop::options do
      banner <<-EOS

Determines a specific motiv in a protein individually.
Examples: "C" to look for Cystein or "P.." looking for Prolein and any two other amino acids.

WRITES TO STANDARD OUT.

Usage:
    ruby pat_stats.rb [options]
where [options] are:
EOS
  opt :aminoacid_file, "input protein sequences as fasta file", :type => :string, :required => true
  opt :pattern, "input pattern to consider", :type => :string, :required => true
end

fasta_file=opts[:aminoacid_file]
pat=opts[:pattern]

puts "sequence\tlength\t#{pat}\t%#{pat}"
Nu::Parser::Fasta.new(fasta_file).each do |seq|
  puts "#{seq.header.gsub(/\t/,' ')}\t#{seq.sequence.length}\t#{seq.sequence.scan(/#{pat}/).count}\t#{seq.sequence.scan(/#{pat}/).count.to_f*pat.length/seq.sequence.length.to_f}"
end
