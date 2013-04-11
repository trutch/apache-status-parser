require 'rubygems'
require 'parslet'
require 'pry-debugger'

buffer=File.open('apachestatus.out','r').read
binding.pry
