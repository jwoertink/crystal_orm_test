module OrmTestCrecto
  extend self

  module Repo
    extend Crecto::Repo

    config do |conf|
      conf.adapter = Crecto::Adapters::Postgres
      conf.hostname = "localhost"
      conf.database = "crystal_orm_test"
    end
  end

  class User < Crecto::Model
    schema "users" do
      field :name, String
    end
  end

  # INSERT INTO users(name) VALUES(whatever)
  def simple_insert
    u = User.new
    u.name = "CrectoGuy #{rand(10_000)}"
    Repo.insert(u)
  end
end
