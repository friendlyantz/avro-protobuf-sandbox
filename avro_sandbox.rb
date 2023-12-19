# frozen_string_literal: true

require 'avro'
require 'pry'

path = 'db/avro_python.bin'
File.open(path)

schema = Avro::Schema.parse(File.read('schemas/person_v2.avsc'))

puts "Decoded using built-in WRITER's schema"
puts Avro::DataFile.open(path).entries

puts '========================================================================'
puts "Decoded using appointed READER's schema"
puts Avro::DataFile.open(path, 'r', schema.to_s).entries # 'r' is for read, 'w' wil ovewrite the file
