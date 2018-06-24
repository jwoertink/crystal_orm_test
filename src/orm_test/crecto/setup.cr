module OrmTestCrecto
  extend self

  module Repo
    extend Crecto::Repo

    config do |conf|
      conf.adapter = Crecto::Adapters::Postgres
      conf.hostname = DATABASE[:host]
      conf.database = DATABASE[:name]
      conf.username = DATABASE[:user]
      conf.password = ""
    end
  end

  class User < Crecto::Model
    schema "users" do
      field :name, String
      field :orm, String
    end
  end

  # INSERT INTO users(name) VALUES(whatever)
  def simple_insert
    u = User.new
    u.name = "CrectoGuy #{rand(10_000)}"
    u.orm = "crecto"
    Repo.insert(u)
  end
  
  # SELECT * FROM users WHERE orm = 'crecto' ORDER BY id ASC
  # Map all of the names in to an array
  def simple_select
    q = Crecto::Repo::Query.where(orm: "crecto").order_by("id ASC")
    Repo.all(User, q).map(&.name)
  end
end
