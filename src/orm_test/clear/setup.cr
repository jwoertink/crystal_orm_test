module OrmTestClear
  extend self

  Clear::SQL.init("postgres://#{DATABASE[:user]}@#{DATABASE[:host]}/#{DATABASE[:name]}")

  class User
    include Clear::Model
    self.table = "users"

    column id : Int32, primary: true, presence: false
    column name : String
    column orm : String
    column created_at : Time, presence: false
    column updated_at : Time, presence: false
  end

  # INSERT INTO users(name) VALUES(whatever)
  def simple_insert
    u = User.new
    u.name = "ClearGuy #{rand(10_000)}"
    u.orm = "clear"
    u.save
  end
end
