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

  # SELECT * FROM users WHERE orm = 'clear' ORDER BY id ASC
  # Map all of the names in to an array
  def simple_select
    User.query.where { orm == "clear" }.order_by({id: :asc}).map(&.name)
  end
end
