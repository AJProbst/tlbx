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

Unalignes fasta files by removing "." and "-" characters from file. Sequences end up in one line (removes line breaks from sequences).
Specify if you want to translate DNA to RNA by adding "-t true".
WRITES TO STANDARD OUT.

Usage:
    ruby unaligner.rb [options]
where [options] are:
EOS
  opt :fasta_file, "input fasta file", :type => :string, :required => true
  opt :translate, "translate from RNA to DNA", :type => :boolean, :default => false
end

fasta_file=opts[:fasta_file]
translate=opts[:translate]
puts fasta_file
Nu::Parser::Fasta.new(fasta_file).each do |seq|
    puts ">"+seq.header.gsub(/\t/,' ')
    if translate
      puts seq.sequence.gsub(/\-/,'').gsub(/\./,'').gsub(/\ /,'').gsub(/U/,'T').gsub(/u/,'t')
    else
      puts seq.sequence.gsub(/\-/,'').gsub(/\./,'').gsub(/\ /,'')
    end
end
