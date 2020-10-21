module OrmTestOnyxSql
  extend self

  class User
    include Onyx::SQL::Model

    schema users do
      pkey id : Int64

      type name : String, not_null: true
      type orm : String, not_null: true
      type idx : Int32, not_null: true
      type created_at : Time, not_null: true, default: true
      type updated_at : Time, not_null: true, default: true
    end
  end

  ENV["DATABASE_URL"] = "postgres://#{DATABASE[:user]}@#{DATABASE[:host]}/#{DATABASE[:name]}"
  Repo = Onyx::SQL::Repository.new(DB.open(ENV["DATABASE_URL"]), Onyx::SQL::Repository::Logger::Dummy.new)

  # INSERT INTO users(name) VALUES(whatever)
  def simple_insert(idx : Int32)
    # TODO: This method throws this error:
    #   Unhandled exception: bind message supplies 1 parameters, but prepared statement "" requires 3 (PQ::PQError)
    #Repo.exec(User.insert(name: "OnyxSqlRecord #{idx}", orm: "onyx_sql", idx: idx))
    sleep 0.05
  end

  # SELECT * FROM users WHERE orm = 'core' ORDER BY id ASC
  # Map all of the names in to an array
  def simple_select(idx : Int32)
    # TODO: This method throws this error:
    #    OnyxSql simple_select Unhandled exception: syntax error at or near ")" (PQ::PQError)
    #
    #query = User.where(orm: "onyx_sql").order_by(:id)
    #result_set = Conn.query(*query.build)
    #User.from_rs(result_set).map(&.name)
    sleep 0.05
  end

  # Find user by orm and idx
  # update name
  # NOTE: This makes 2 SQL calls. Though it's not "optimized", it's more practical for real world
  def simple_update(idx_value : Int32)
    # TODO: This method throws this error:
    #    OnyxSql simple_update Unhandled exception: syntax error at or near "AND" (PQ::PQError)
    #
    #query = User.where(orm: "onyx_sql", idx: idx_value)
    #user = User.from_rs(Conn.query(*query.build)).first?.not_nil!
    #changeset = user.changeset
    #changeset.update(name: "OnyxSql #{idx_value}")
    sleep 0.05
  end

  # Find user by orm and idx
  # delete user
  def simple_delete(idx : Int32)
    query = User.where(orm: "onyx_sql", idx: idx)
    user = User.from_rs(Repo.query(*query.build)).first?.not_nil!
    user.delete
  end
end
