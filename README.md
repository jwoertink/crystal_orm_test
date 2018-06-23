# Crystal ORM test

This is an ORM comparrison test for crystal. This test will compare a few different ORMs specifically using PostgreSQL. 

### Testing Goals

* Setup and connecting to Postgres
* Speed of simple SELECT query
* Speed of simple UPDATE query
* Speed of simple INSERT query
* Speed of simple DELETE query
* Speed of complex SELECT query

## Requirements

1. Crystal ~> 0.25
2. PostgreSQL ~> 9.6

## Running test

* Fork and clone
* `shards install`
* `./bin/setup`
* `crystal build --release src/orm_test.cr -o run`
* `./run`

## ISSUES

1. Update to BIGSERIAL (Int64) once LuckyRecord supports it
2. Jennifer does not support latest crystal yet

## Subjects

1. [Clear](https://github.com/anykeyh/clear)
2. [Core](https://github.com/vladfaust/core)
3. [Crecto](https://github.com/Crecto/crecto)
4. [Granite](https://github.com/amberframework/granite)
5. [Jennifer](https://github.com/imdrasil/jennifer.cr)
6. [LuckyRecord](https://github.com/luckyframework/lucky_record)

Let me know if there's another ORM that should be thrown in.

## Results
Specs:
```
Machine: 2017 MBP 2.7GHz i7 16GB RAM
OS: macOS 10.13.5
Crystal 0.25.0
PG: 9.6.3
```

```
                                 user     system      total        real
clear simple_insert          0.000000   0.000000   0.000000 (  0.001366)
crecto simple_insert         0.040000   0.020000   0.060000 (  0.312254)
lucky_record simple_insert   0.040000   0.050000   0.090000 (  0.415375)
core simple_insert           0.030000   0.020000   0.050000 (  0.288875)
granite simple_insert        0.020000   0.020000   0.040000 (  0.279746)
```


