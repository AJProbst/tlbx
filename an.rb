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

Annotates a fasta file from a given tab-delimited fasta=header to anntoation file. Fasta header is replaced by annotation!
WRITES TO STANDARD OUT.

Usage:
    ruby an.rb [options]
where [options] are:
EOS
  opt :fasta, "fasta file", :type => :string, :required => true
  opt :annotation, "tab-delimited file that has the fasta header in column 1 and the annotation in column 2", :type => :string, :required => true
end

fasta_file=opts[:fasta]
anno=opts[:annotation]

lookup = Hash.new

File.open("#{anno}").each do |line|
  line.chomp
  cols = line.split(/\t/)
  fasta_id = cols[0]
  annot = cols[1]
  lookup[fasta_id]=annot
end


Nu::Parser::Fasta.new(fasta_file).each do |seq|
  puts ">#{lookup[seq.header]}"
  puts seq.sequence
end
