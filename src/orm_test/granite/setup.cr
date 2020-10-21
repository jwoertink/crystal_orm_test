module OrmTestGranite
  extend self

  Granite::Connections << Granite::Adapter::Pg.new(name: "pg", url: "postgres://#{DATABASE[:user]}@#{DATABASE[:host]}/#{DATABASE[:name]}")
  #Granite.settings.logger = ::Logger.new(nil)

  class User < Granite::Base
    extend Granite::Query::BuilderMethods
    connection pg
    table users
    column id : Int64, primary: true
    column name : String
    column orm : String
    column idx : Int32
    timestamps
  end

  # INSERT INTO users(name) VALUES(whatever)
  def simple_insert(idx : Int32)
    User.create(name: "GraniteRecord #{idx}", orm: "granite", idx: idx)
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
    u = User.find_by(orm: "granite", idx: idx_value).as(User)
    u.update(name: "Granite #{idx_value}")
  end

  # Find user by orm and idx
  # delete user
  def simple_delete(idx : Int32)
    u = User.find_by(orm: "granite", idx: idx).as(User)
    u.destroy
  end
end
