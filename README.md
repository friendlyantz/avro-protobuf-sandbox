# Action Plan

- [ ] ~~install and study [Avro (Ruby Gem)](https://rubygems.org/gems/avro) `bundle add avro`~~
- [x] install and study [Avro Turf(Ruby Gem)](https://github.com/dasch/avro_turf) `bundle add avro_turf`
- [ ] install protobuf and compare results


# Notes 

## Avro Turf

Decided to ignore Avro and go straight into AvroTurf

1. I hardcoded schemas for `person` that includes another schema for `address`
```avsh
{
    "name": "person",
        "type": "record",
        "fields": [
        {
            "name": "name",
            "type": "string"
        },
        {
            "name": "age",
            "type": "int"
        },
        {
            "name": "address",
            "type": "address"
        }
        ]
}
```

Basic data packed will be smth alike this:
```ruby
{ "name" => "Ruby",
    "age" => 77, 
    "address" => {
        "city" => "Melbourne",
        "street" => "Collins Street"
    }
}
```

2. And then experimented in simple avro ruby script to encode/decode data in avro and store binaries under `db` dir (for potential comparison with protobuf)
