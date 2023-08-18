import avro.schema
from avro.datafile import DataFileReader, DataFileWriter
from avro.io import DatumReader, DatumWriter

schema = avro.schema.parse(open("schemas/person.avsc", "rb").read())

writer = DataFileWriter(open("db/avro_python.bin", "wb"), DatumWriter(), schema)

writer.append(
        {
            "name": "Python🐍",
            "age": 256,
            "address": {
                "city": "San Francisco",
                "street": "Green Street"
                }
            }
        )

writer.append(
        {
            "name": "Mojo🐍",
            "age": 1,
            "address": {
                "city": "Saturn🪐",
                "street": "Blue Street"
                }
            }
        )

writer.close()

reader_python = DataFileReader(open("db/avro_python.bin", "rb"), DatumReader())
for person in reader_python:
    print(person)
reader_python.close()

print("=========================================")

reader_ruby = DataFileReader(open("db/avro_ruby.bin", "rb"), DatumReader())
for person in reader_ruby:
    print(person)
reader_ruby.close()

reader_anton = DataFileReader(open("db/avro_anton.bin", "rb"), DatumReader())
for person in reader_anton:
    print(person)
reader_anton.close()

