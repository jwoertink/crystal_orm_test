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

1. Crystal >= 1.10
2. PostgreSQL > 12

## Running test

* Fork and clone
* `shards install`
* `./script/setup`
* `crystal build --release src/orm_test.cr -o run`
* `./run`

Configure any database credentials you need with environment variables

`DB_HOST`, `DB_USER`, `DB_PASS`

## Subjects

1. [Avram](https://github.com/luckyframework/avram)
1. [Clear](https://github.com/anykeyh/clear)
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

Specs:
```
Machine: 2021 System76 Thelio 3.7GHz AMD Ryzen 5 5600X 64GB RAM
OS: Pop!_OS 22.04 LTS x86_64
Crystal 1.12.1
PG: 14
DATE: 2024-07-13
```

```
BENCHMARKING simple_insert
                             user     system      total        real
Avram simple_insert      0.035337   0.062070   0.097407 (  2.410567)
Clear simple_insert      0.034263   0.051799   0.086062 (  2.373634)
Crecto simple_insert     0.035744   0.023926   0.059670 (  2.212781)
Granite simple_insert    0.011970   0.038810   0.050780 (  2.184863)
Jennifer simple_insert   0.028194   0.066368   0.094562 (  2.353238)
BENCHMARKING simple_select
                             user     system      total        real
Avram simple_select      0.865771   0.135182   1.000953 (  2.022358)
Clear simple_select      2.412488   0.076082   2.488570 (  2.880314)
Crecto simple_select     1.026289   0.188711   1.215000 (  2.237350)
Granite simple_select    0.281183   0.063481   0.344664 (  0.684120)
Jennifer simple_select   0.300742   0.056913   0.357655 (  0.722590)
BENCHMARKING simple_update
                             user     system      total        real
Avram simple_update      0.065531   0.075846   0.141377 (  2.657366)
Clear simple_update      0.029919   0.077393   0.107312 (  2.413604)
Crecto simple_update     0.053114   0.039067   0.092181 (  2.749676)
Granite simple_update    0.032240   0.053979   0.086219 (  2.627631)
Jennifer simple_update   0.035657   0.042333   0.077990 (  2.801805)
BENCHMARKING simple_delete
                             user     system      total        real
Avram simple_delete      0.035713   0.049531   0.085244 (  2.574109)
Clear simple_delete      0.049509   0.083932   0.133441 (  2.537720)
Crecto simple_delete     0.027137   0.047006   0.074143 (  2.335193)
Granite simple_delete    0.037229   0.064698   0.101927 (  2.423307)
Jennifer simple_delete   0.036081   0.093909   0.129990 (  2.562659)
```

## Motivation / Backstory
Around 2016 when I started my first crystal project, there was only like 1 or 2 ORM options to choose, but they didn't work well. Your best option was to just use some raw SQL. Now, there's an explosion of ORMs, and too many to choose from. If your app is using [Kemal](http://kemalcr.com/), and you want to use an ORM, which do you choose?

This is about more than just speed. How well documented are these, which features do they support, how easy are they to setup, what does the query DSL and the models look like? Sometimes a little performance tradeoff is worth the hassel if it's easier to work with.
