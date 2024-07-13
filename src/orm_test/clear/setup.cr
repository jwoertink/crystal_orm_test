module OrmTestClear
  extend self

  Clear::SQL.init("postgres://#{DATABASE[:user]}@#{DATABASE[:host]}/#{DATABASE[:name]}")

  class User
    include Clear::Model
    self.table = "users"

    column id : Int64, primary: true, presence: false
    column name : String
    column orm : String
    column idx : Int32
    column created_at : Time, presence: false
    column updated_at : Time, presence: false
  end

  # INSERT INTO users(name) VALUES(whatever)
  def simple_insert(idx : Int32)
    u = User.new
    u.name = "ClearRecord #{idx}"
    u.orm = "clear"
    u.idx = idx
    u.save!
  end

  # SELECT * FROM users WHERE orm = 'clear' ORDER BY id ASC
  # Map all of the names in to an array
  def simple_select(idx : Int32)
    User.query.where { orm == "clear" }.order_by({id: :asc}).map(&.name)
  end

  # Find user by orm and idx
  # update name
  # NOTE: This makes 2 SQL calls. Though it's not "optimized", it's more practical for real world
  def simple_update(idx_value : Int32)
    u = User.query.where { (orm == "clear") & (idx == idx_value) }.first.as(User)
    u.name = "Clear #{idx_value}"
    u.save!
  end

  # Find user by orm and idx
  # delete user
  def simple_delete(idx_value : Int32)
    u = User.query.where { (orm == "clear") & (idx == idx_value) }.first.as(User)
    u.delete
  end
end
