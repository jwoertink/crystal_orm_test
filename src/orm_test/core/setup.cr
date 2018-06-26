module OrmTestCore
  extend self

  class User
    include Core::Schema
    include Core::Query

    schema :users do
      primary_key :id

      field :name, String
      field :orm, String
      field :idx, Int32
      field :created_at, Time, db_default: true
      field :updated_at, Time, db_default: true
    end
  end

  DB = PG.connect("postgres://#{DATABASE[:user]}@#{DATABASE[:host]}/#{DATABASE[:name]}")
  Repo = Core::Repository.new(DB)

  # INSERT INTO users(name) VALUES(whatever)
  def simple_insert(idx : Int32)
    u = User.new(name: "CoreGuy #{idx}", orm: "core", idx: idx)
    Repo.insert(u)
  end
  
  # SELECT * FROM users WHERE orm = 'core' ORDER BY id ASC
  # Map all of the names in to an array
  def simple_select(idx : Int32)
    Repo.query(User.where(orm: "core").order_by("id", :ASC)).map(&.name)
  end
  
  # Find user by orm and idx
  # update name
  # NOTE: This makes 2 SQL calls. Though it's not "optimized", it's more practical for real world
  def simple_update(idx_value : Int32)
    u = Repo.query_one(User.where(orm: "core", idx: idx_value)).as(User)
    u.name = "Core Guy#{idx_value}"
    Repo.update(u)
  end

  # Find user by orm and idx
  # delete user
  def simple_delete(idx : Int32)
    u = Repo.query_one(User.where(orm: "core", idx: idx)).as(User)
    Repo.delete(u)
  end
end
