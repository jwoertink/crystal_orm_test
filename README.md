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
BENCHMARKING simple_insert
                                 user     system      total        real
clear simple_insert          0.040000   0.020000   0.060000 (  0.348617)
core simple_insert           0.020000   0.020000   0.040000 (  0.316705)
crecto simple_insert         0.040000   0.020000   0.060000 (  0.357646)
granite simple_insert        0.030000   0.020000   0.050000 (  0.311737)
lucky_record simple_insert   0.060000   0.050000   0.110000 (  0.506803)

BENCHMARKING simple_select
                                 user     system      total        real
clear simple_select          2.840000   0.930000   3.770000 (  2.670658)
core simple_select           1.640000   0.390000   2.030000 (  1.831673)
crecto simple_select         1.000000   0.210000   1.210000 (  1.331577)
granite simple_select        0.980000   0.210000   1.190000 (  1.279650)
lucky_record simple_select   0.970000   0.210000   1.180000 (  1.395014)
```

## Motivation / Backstory
Around 2016 when I started my first crystal project, there was only like 1 or 2 ORM options to choose, but they didn't work well. Your best option was to just use some raw SQL. Now, there's an explosion of ORMs, and too many to choose from. If your app is using [Kemal](http://kemalcr.com/), and you want to use an ORM, which do you choose? 

This is about more than just speed. How well documented are these, which features do they support, how easy are they to setup, what does the query DSL and the models look like? Sometimes a little performance tradeoff is worth the hassel if it's easier to work with.

