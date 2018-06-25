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
    timestamps
  end
  
  # INSERT INTO users(name) VALUES(whatever)
  def simple_insert
    u = User.new
    u.name = "GraniteGuy #{rand(10_000)}"
    u.orm = "granite"
    u.save
  end
  
  # SELECT * FROM users WHERE orm = 'granite' ORDER BY id ASC
  # Map all of the names in to an array
  def simple_select
    User.where(orm: "granite").order(id: :asc).map(&.name)
  end
end
