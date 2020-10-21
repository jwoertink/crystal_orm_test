require "benchmark"
require "./orm_test/*"

DATABASE = {host: "localhost", name: "crystal_orm_test", user: "postgres"}

# Enable all once updated
# ["Avram", "Clear", "Crecto", "Granite", "Jennifer", "OnyxSql"]

{% for test in ["simple_insert", "simple_select", "simple_update", "simple_delete"] %}

  puts "BENCHMARKING {{test.id}}"
  Benchmark.bm do |x|
    {% for subject in ["Avram", "Crecto", "Granite", "Jennifer"] %}
      x.report("{{subject.id}} {{test.id}}") do
        1000.times do |i|
          OrmTest{{subject.id}}.{{test.id}}(i)
        end
      end
    {% end %}
  end

{% end %}
