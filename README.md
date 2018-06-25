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
Clear simple_insert         0.030000   0.020000   0.050000 (  0.340290)
Core simple_insert          0.030000   0.020000   0.050000 (  0.317419)
Crecto simple_insert        0.040000   0.020000   0.060000 (  0.346847)
Granite simple_insert       0.020000   0.020000   0.040000 (  0.308507)
LuckyRecord simple_insert   0.060000   0.040000   0.100000 (  0.462734)

BENCHMARKING simple_select
                                user     system      total        real
Clear simple_select         2.940000   0.730000   3.670000 (  2.859489)
Core simple_select          1.810000   0.430000   2.240000 (  1.968253)
Crecto simple_select        1.170000   0.260000   1.430000 (  1.454140)
Granite simple_select       1.090000   0.260000   1.350000 (  1.411098)
LuckyRecord simple_select   1.120000   0.240000   1.360000 (  1.532002)

BENCHMARKING simple_update
                                user     system      total        real
Clear simple_update         0.090000   0.030000   0.120000 (  0.642692)
Core simple_update          0.050000   0.030000   0.080000 (  0.547988)
Crecto simple_update        0.080000   0.040000   0.120000 (  0.624735)
Granite simple_update       0.040000   0.020000   0.060000 (  0.594069)
LuckyRecord simple_update   0.090000   0.060000   0.150000 (  0.716832)
```

For some fun, I decided to port this test to ActiveRecord (Ruby), and see how it compares. The theory was that it would be a little slower, but not by much. Here's the results

```
       user     system      total        real
activerecord simple_insert  0.570000   0.060000   0.630000 (  1.014383)
       user     system      total        real
activerecord simple_select 11.950000   0.210000  12.160000 ( 13.046481)
       user     system      total        real
activerecord simple_update  0.900000   0.080000   0.980000 (  1.560936)
```
The code is [here](https://gist.github.com/jwoertink/55f474ddb0d2322e09d32af887a07bc9)

## Motivation / Backstory
Around 2016 when I started my first crystal project, there was only like 1 or 2 ORM options to choose, but they didn't work well. Your best option was to just use some raw SQL. Now, there's an explosion of ORMs, and too many to choose from. If your app is using [Kemal](http://kemalcr.com/), and you want to use an ORM, which do you choose? 

This is about more than just speed. How well documented are these, which features do they support, how easy are they to setup, what does the query DSL and the models look like? Sometimes a little performance tradeoff is worth the hassel if it's easier to work with.

