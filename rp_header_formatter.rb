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

Will give all fasta sequences in a file the file name (before the period) as the header. WRITES TO STANDARD OUT

Usage:
        ruby rp_header_formatter.rb [option]
where [options] are:
EOS
  opt :file, "file that needs to be renamed", :type => :string, :required => true
end

name=opts[:file]

Nu::Parser::Fasta.new(name).each do |seq|
  puts ">#{name.split(".")[0]}"
  puts seq.sequence
end
