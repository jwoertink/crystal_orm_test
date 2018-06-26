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
      field :idx, Int32
    end
  end

  # INSERT INTO users(name) VALUES(whatever)
  def simple_insert(idx : Int32)
    u = User.new
    u.name = "CrectoGuy #{idx}"
    u.orm = "crecto"
    u.idx = idx
    Repo.insert(u)
  end
  
  # SELECT * FROM users WHERE orm = 'crecto' ORDER BY id ASC
  # Map all of the names in to an array
  def simple_select(idx : Int32)
    q = Crecto::Repo::Query.where(orm: "crecto").order_by("id ASC")
    Repo.all(User, q).map(&.name)
  end
  
  # Find user by orm and idx
  # update name
  # NOTE: This makes 2 SQL calls. Though it's not "optimized", it's more practical for real world
  def simple_update(idx_value : Int32)
    u = Repo.get_by(User, orm: "crecto", idx: idx_value).as(User)
    u.name = "Crecto Guy#{idx_value}"
    Repo.update(u)
  end
  
  # Find user by orm and idx
  # delete user
  def simple_delete(idx : Int32)
    u = Repo.get_by(User, orm: "crecto", idx: idx).as(User)
    Repo.delete(u)
  end
end
