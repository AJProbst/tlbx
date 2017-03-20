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

adds "_c" to the end each scaffold name and discards comments. adds "curated" to end of file name.

Usage:
        ruby scaff2scaff_cur.rb [option]
where [options] are:
EOS
    opt :file, "file to be converted, needs to end with .fa", :type => :string, :required => true
end

input=opts[:file]
output=input.gsub(/\.fa/,'.curated.fa')

File.open(output, "w+") do |file|
  Nu::Parser::Fasta.new(input).each do |seq|
    file.puts ">#{seq.header.split[0]}_c"
    file.puts seq.sequence
  end
end
