module OrmTestGranite
  extend self

  ENV["DATABASE_URL"] = "postgres://#{DATABASE[:user]}@#{DATABASE[:host]}/#{DATABASE[:name]}"
  Granite.settings.logger = ::Logger.new(nil)

  class User < Granite::Base
    adapter pg
    table_name users
    primary id : Int32
    field name : String
    timestamps
  end
  
  # INSERT INTO users(name) VALUES(whatever)
  def simple_insert
    u = User.new
    u.name = "GraniteGuy #{rand(10_000)}"
    u.save
  end
end
