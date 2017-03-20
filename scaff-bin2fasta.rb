#!/usr/bin/ruby -w

# The MIT License (MIT)
# Copyright (c) 2016 Alexander J Probst

# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require "trollop"

opts=Trollop::options do
  banner <<-EOS

Creates individual fasta files from a main fasta file and a scaffold2bin file. Names in the scaffold2bin file is used as file names.

Usage:
  ruby scaff-bin2fasta.rb [option]
  where [options] are:
EOS
  opt :scaff_2_bin, "scaffold2bin file", :type => :string, :required => true
  opt :fasta_file, "input fasta file", :type => :string, :required => true
end

scaff2bin=opts[:scaff_2_bin]
fastafile=opts[:fasta_file]

puts "reading input files..."
h1 = Hash.new{|h,k| h[k]=[]}
File.open(scaff2bin).each do | line |
  line.chomp!
  cols = line.split(/\t/)
  scaff = cols[0]
  bin = cols[1]
  s = h1[bin]
  s.push(scaff)
end

puts "creating individual bins..."
h1.each do |bin, scaffs|
  File.open(bin, "w+") do |f|
    f.puts(scaffs)
  end
  `pullseq -i #{fastafile} -n #{bin} > #{bin}.fasta`
  `rm #{bin}`
end

puts "all bins extracted as fasta!"
