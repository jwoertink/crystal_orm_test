# Crystal ORM test

This is an ORM comparrison test for crystal. This test will compare a few different ORMs specifically using PostgreSQL.

### Testing Goals

* Setup and connecting to Postgres
* Speed of simple SELECT query
* Speed of simple UPDATE query
* Speed of simple INSERT query
* Speed of simple DELETE query
* Speed of complex SELECT query (TBD)

## Requirements

1. Crystal ~> 0.35
2. PostgreSQL > 10

## Running test

* Fork and clone
* `shards install`
* `./script/setup`
* `crystal build --release src/orm_test.cr -o run`
* `./run`

## Subjects

1. [Avram](https://github.com/luckyframework/avram)
1. [Clear](https://github.com/anykeyh/clear)  (currently disabled until support for db 0.10)
1. [Crecto](https://github.com/Crecto/crecto)
1. [Granite](https://github.com/amberframework/granite)
1. [Jennifer](https://github.com/imdrasil/jennifer.cr)
1. [OnyxSql](https://github.com/onyxframework/sql) (currently disabled until I can figure out how to use it....)

Let me know if there's another ORM that should be thrown in.

## Results
Specs:
```
Machine: 2017 MBP 2.7GHz i7 16GB RAM
OS: macOS 10.15.7
Crystal 0.35.1
PG: 12.3
DATE: 2020-10-21
```

```
BENCHMARKING simple_insert
                             user     system      total        real
Avram simple_insert      0.047403   0.036590   0.083993 (  0.441650)
Crecto simple_insert     0.032824   0.016297   0.049121 (  0.320013)
Granite simple_insert    0.017574   0.012746   0.030320 (  0.293740)
Jennifer simple_insert   0.031753   0.031404   0.063157 (  0.409382)
BENCHMARKING simple_select
                             user     system      total        real
Avram simple_select      0.974615   0.256200   1.230815 (  1.401163)
Crecto simple_select     1.014145   0.288999   1.303144 (  1.257788)
Granite simple_select    1.024089   0.235854   1.259943 (  1.329068)
Jennifer simple_select   0.948327   0.214113   1.162440 (  1.263242)
BENCHMARKING simple_update
                             user     system      total        real
Avram simple_update      0.078030   0.049248   0.127278 (  0.686803)
Crecto simple_update     0.061099   0.028421   0.089520 (  0.573595)
Granite simple_update    0.039218   0.025861   0.065079 (  0.534693)
Jennifer simple_update   0.031984   0.024204   0.056188 (  0.507185)
BENCHMARKING simple_delete
                             user     system      total        real
Avram simple_delete      0.034659   0.026383   0.061042 (  0.505111)
Crecto simple_delete     0.046740   0.030638   0.077378 (  0.496973)
Granite simple_delete    0.035885   0.026586   0.062471 (  0.437627)
Jennifer simple_delete   0.048359   0.044234   0.092593 (  0.526131)
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
