module OrmTestAvram
  extend self

  Avram::Log.dexter.configure(:none)

  class AppDatabase < Avram::Database
  end

  AppDatabase.configure do |settings|
    settings.credentials = Avram::Credentials.new(database: DATABASE[:name], username: DATABASE[:user], hostname: DATABASE[:host])
  end

  Avram.configure do |settings|
    settings.database_to_migrate = AppDatabase

    # In production, allow lazy loading (N+1).
    # In development and test, raise an error if you forget to preload associations
    settings.lazy_load_enabled = true
  end

  class User < Avram::Model
    def self.database : Avram::Database.class
      AppDatabase
    end

    table :users do
      column name : String
      column orm : String
      column idx : Int32
    end
  end

  class SaveUser < User::SaveOperation
    permit_columns name
  end

  # INSERT INTO users(name) VALUES(whatever)
  def simple_insert(idx : Int32)
    SaveUser.create!(
      name: "AvramRecord #{idx}",
      orm: "avram",
      idx: idx
    )
  end

  # SELECT * FROM users WHERE orm = 'avram' ORDER BY id ASC
  # Map all of the names in to an array
  def simple_select(idx : Int32)
    User::BaseQuery.new.orm("avram").id.asc_order.map(&.name)
  end

  # Find user by orm and idx
  # update name
  # NOTE: This makes 2 SQL calls. Though it's not "optimized", it's more practical for real world
  def simple_update(idx_value : Int32)
    u = User::BaseQuery.new.orm("avram").idx(idx_value).first
    SaveUser.update!(u, name: "Avram #{idx_value}")
  end

  # Find user by orm and idx
  # delete user
  def simple_delete(idx : Int32)
    u = User::BaseQuery.new.orm("avram").idx(idx).first
    u.delete
  end
end
