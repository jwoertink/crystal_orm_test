module OrmTestJennifer
  extend self

  Jennifer::Config.configure do |conf|
    conf.host = DATABASE[:host]
    conf.user = DATABASE[:user]
    conf.db = DATABASE[:name]
    conf.password = ""
    conf.adapter = "postgres"
  end

  class User < Jennifer::Model::Base
    with_timestamps
    mapping(
      id: Primary32, 
      name: String,
      orm: String,
      idx: Int32,
      created_at: Time,
      updated_at: Time
    )
  end

  # INSERT INTO users(name) VALUES(whatever)
  def simple_insert(idx : Int32)
    u = User.new({
      name: "JenniferGuy #{idx}",
      orm: "jennifer",
      idx: idx
    })
    u.save
  end
  
  # SELECT * FROM users WHERE orm = 'jennifer' ORDER BY id ASC
  # Map all of the names in to an array
  def simple_select(idx : Int32)
    User.where { _orm == "jennifer" }.order(id: :asc).to_a.map(&.name)
  end
  
  # Find user by orm and idx
  # update name
  # NOTE: This makes 2 SQL calls. Though it's not "optimized", it's more practical for real world
  def simple_update(idx_value : Int32)
    u = User.where { (_orm == "jennifer") & (_idx == idx_value) }.first!
    u.update_column("name", "Jennifer Guy#{idx_value}")
  end
  
  def simple_delete(idx : Int32)
    u = User.where { (_orm == "jennifer") & (_idx == idx) }.first!
    User.destroy(u.id)
  end
end
