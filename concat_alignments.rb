#!/usr/bin/ruby -w

# The MIT License (MIT)
# Copyright (c) 2016 Alexander J Probst

# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require "nu"
require "trollop"


opts=Trollop::options do
  banner <<-EOS
Creates an concatenated alignment from multiple trimmed alignment files. Fasta headers of across files need to be identical for their concatenation.
Needs to be executed in the folder containing the files or the flatfile needs to have the absolute paths.
Usage:
        ruby concat_alignments.rb [option]
where [options] are:
EOS
  opt :flat_file, "input file listing trimmed alignment files", :type => :io, :required => true
  opt :output, "name of the output file", :type => :string, :required => false
end

flat_file=opts[:flat_file]
max_missing=opts[:max_missing]
output=opts[:output] || "output.fasta"

aln_files=flat_file.read.split("\n")

alignments=Hash.new{|h,k| h[k]={}}
seq_length_lookup={}
aln_files.each_with_index do |file, i|
  Nu::Parser::Fasta.new(file).each_with_index do |seq, j|
    alignments[seq.header_name][i]=seq.sequence
    if j==0
        seq_length_lookup[i]=seq.sequence.length
    end
  end
end

concats=Hash.new{}
alignments.each do |organism, seq|
  concat_seq=""
  seq_length_lookup.keys.each do |i|
    if seq[i]
      concat_seq+=seq[i]
    else
      concat_seq+="-"*seq_length_lookup[i]
    end
  end
  concats[organism]=concat_seq
end

File.open(output, "w") do |file|
  concats.each do |org, seq|
    file.puts ">#{org}"
    file.puts seq
  end
end

puts "done, file #{output} has been written."
