require 'nokogiri'

f = File.open(File.join(__dir__, 'note.xml'), 'r')
doc = Nokogiri::XML(f)
f.close
puts doc
