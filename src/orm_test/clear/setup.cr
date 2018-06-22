module OrmTestClear
  extend self

  Clear::SQL.init("postgres://postgres@localhost/crystal_orm_test")

  class User
    include Clear::Model

    column id : Int64, primary: true
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
