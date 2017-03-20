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

Converts prodigal predicted aminoacid names back to scaffold names, i.e. fasta headers will have the  "_[1-9]" the end removed and the headers will be printed to STANDARD OUT.

Usage:
        ruby prot2scaff.rb [option]
where [options] are:
EOS
  opt :fasta_file, "input fasta file", :type => :string, :required => true
end

fasta_file=opts[:fasta_file]

seq_length = 0

Nu::Parser::Fasta.new(fasta_file).each do |seq|
  puts seq.name.split(" ")[0].split("_")[0...-1].join("_")
end
