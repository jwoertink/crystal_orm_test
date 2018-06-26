module OrmTestGranite
  extend self

  ENV["DATABASE_URL"] = "postgres://#{DATABASE[:user]}@#{DATABASE[:host]}/#{DATABASE[:name]}"
  Granite.settings.logger = ::Logger.new(nil)

  class User < Granite::Base
    extend Granite::Query::BuilderMethods
    adapter pg
    table_name users
    primary id : Int32
    field name : String
    field orm : String
    field idx : Int32
    timestamps
  end
  
  # INSERT INTO users(name) VALUES(whatever)
  def simple_insert(idx : Int32)
    u = User.new
    u.name = "GraniteGuy #{idx}"
    u.orm = "granite"
    u.idx = idx
    u.save
  end
  
  # SELECT * FROM users WHERE orm = 'granite' ORDER BY id ASC
  # Map all of the names in to an array
  def simple_select(idx : Int32)
    User.where(orm: "granite").order(id: :asc).map(&.name)
  end
  
  # Find user by orm and idx
  # update name
  # NOTE: This makes 2 SQL calls. Though it's not "optimized", it's more practical for real world
  def simple_update(idx_value : Int32)
    u = User.where(orm: "granite", idx: idx_value).first.as(User)
    u.name = "Granite Guy#{idx_value}"
    u.save
  end
  
  # Find user by orm and idx
  # delete user
  def simple_delete(idx : Int32)
    u = User.where(orm: "granite", idx: idx).first.as(User)
    u.destroy
  end
end
