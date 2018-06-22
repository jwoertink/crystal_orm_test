module OrmTestClear
  extend self

  Clear::SQL.init("postgres://#{DATABASE[:user]}@#{DATABASE[:host]}/#{DATABASE[:name]}")

  class User
    include Clear::Model
    self.table = "users"

    column id : Int32, primary: true
    column name : String
    column created_at : Time
    column updated_at : Time 
  end

  # INSERT INTO users(name) VALUES(whatever)
  def simple_insert
    u = User.new
    u.name = "ClearGuy #{rand(10_000)}"
    u.save
  end
end
