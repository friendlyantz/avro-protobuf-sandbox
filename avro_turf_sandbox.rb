# frozen_string_literal: true

require 'avro_turf'
require 'pry'

# Schemas will be looked up from the specified directory.
AVRO = AvroTurf.new(schemas_path: 'schemas/')

def decode(encoded_data)
  # Decode some data using a named schema. The schema file should exist in the
  # schemas directory with the file name `<name>.avsc`.
  AVRO.decode(encoded_data, schema_name: 'person')
  # TODO: figure out how to decode multiple objects from one file
end

def decode_with_new_schema(encoded_data)
  AVRO.decode(encoded_data, schema_name: 'person_v2')
end

avro_encoded_object = AVRO.encode(
  { 'name' => 'Ruby💎',
    'age' => 77,
    # includes another fields from schema for `address`
    'address' => {
      'city' => 'Melbourne',
      'street' => 'Collins Street'
    } },
  schema_name: 'person',
  # Data can be validated before encoding to get a description of problem through
  # Avro::SchemaValidator::ValidationError exception
  validate: true
)

avro_db_path = 'db/avro_ruby.bin'
File.open(avro_db_path, 'w') do |file|
  file.write(avro_encoded_object)
end

puts "Avro Encoded object saved in '#{avro_db_path}':"
puts avro_encoded_object

puts '========================================================================'

decoded_object = decode(avro_encoded_object)
puts 'Avro Decoded object:'
puts decoded_object

puts '========================================================================'

decoded_avro_object_for_anton = decode(File.read('db/avro_anton.bin'))
puts 'Avro Decoded object for Anton:'
puts decoded_avro_object_for_anton

puts '========================================================================'

decoded_avro_object_for_vlad = decode(File.read('db/avro_vlad.bin'))
puts 'Avro Decoded object for Vlad:'
puts decoded_avro_object_for_vlad

puts '========================================================================'

puts 'Avro Decoded object for Python🐍:'
File.open('db/avro_python.bin').each_line do |line|
  # FIXME: not sure how to decode multiple records from one payload
  # This can be done in standard `avro` gem using
  # Avro::DataFile.open('db/avro_python.bin').entries
  decoded_avro_object_for_python = decode(line)
  puts decoded_avro_object_for_python
end

puts '========================================================================'

puts 'Avro SCHEMALESS Decoded object for Python🐍:'
File.open('db/avro_python.bin').each_line do |line|
  # FIXME: not sure how to decode multiple records from one payload
  decoded_avro_object_for_python = AVRO.decode(line)
  puts decoded_avro_object_for_python
end

puts '========================================================================'
puts '========================================================================'
decoded_avro_object_for_anton_with_new_schema = decode_with_new_schema(
  File.read('db/avro_anton.bin')
)
puts 'Avro Decoded object for Anton using schema v2 (SCHEMA EVOLUTION):'
puts decoded_avro_object_for_anton_with_new_schema

avro_encoded_object_with_new_schema = AVRO.encode(
  {
    'name' => 'Ruby_with_evolved_schema💎',
    'fav_color' => 'orange🟠', # this is required for writing
    'age' => 88
  },
  schema_name: 'person_v2',
  validate: true
)

puts '========================================================================'
puts 'Avro Decoded - (SCHEMALESS/writes schema only):'
puts AVRO.decode(avro_encoded_object_with_new_schema)
