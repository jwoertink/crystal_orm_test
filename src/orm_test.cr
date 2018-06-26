require "benchmark"
require "./orm_test/*"

DATABASE = {host: "localhost", name: "crystal_orm_test", user: "postgres"}

{% for test in ["simple_insert", "simple_select", "simple_update", "simple_delete"] %}

  def bench_{{test.id}}
    puts "BENCHMARKING {{test.id}}"
    Benchmark.bm do |x|
      {% for subject in ["Clear", "Core", "Crecto", "Granite", "LuckyRecord"] %}
        x.report("{{subject.id}} {{test.id}}") do
          1000.times do |i|
            OrmTest{{subject.id}}.{{test.id}}(i)
          end
        end
      {% end %}
    end
  end

  bench_{{test.id}}

{% end %}
