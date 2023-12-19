# frozen_string_literal: true

require 'nokogiri'
require 'awesome_print'

PO_XML_FILE = File.join(__dir__, 'note.xml')
PO_SCHEMA_FILE = File.join(__dir__, 'note.xsd')

file = File.open(PO_XML_FILE, 'r')
doc = Nokogiri::XML(file)
file.close

schema = Nokogiri::XML::Schema(File.read(PO_SCHEMA_FILE))
ap '*' * 80
ap 'validation start'
schema.validate(doc).each { |error| puts error.message }
ap 'validation complete'
ap '*' * 80

ap doc
