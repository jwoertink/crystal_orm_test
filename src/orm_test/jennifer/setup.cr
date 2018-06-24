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
      created_at: Time,
      updated_at: Time
    )
  end

  # INSERT INTO users(name) VALUES(whatever)
  def simple_insert
    u = User.new
    u.name = "JenniferGuy #{rand(10_000)}"
    u.orm = "jennifer"
    u.save
  end
end
