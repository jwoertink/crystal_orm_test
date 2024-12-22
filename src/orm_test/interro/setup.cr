require "interro"

module OrmTestInterro
  extend self

  db = DB.open("postgres:///#{DATABASE[:name]}")
  Interro.config do |c|
    c.db = db
  end

  struct User
    include DB::Serializable

    getter id : Int64
    getter name : String
    getter orm : ORM
    getter idx : Int32

    enum ORM
      Avram
      Clear
      Crecto
      Granite
      Interro
      Jennifer
      OnyxSQL

      def to_s
        case self
        in .avram?
          "avram"
        in .clear?
          "clear"
        in .crecto?
          "crecto"
        in .granite?
          "granite"
        in .interro?
          "interro"
        in .jennifer?
          "jennifer"
        in .onyx_sql?
          "onyx_sql"
        end
      end
    end
  end

  struct UserQuery < Interro::QueryBuilder(User)
    table "users"

    def find_by_idx!(idx : Int32) : User
      where(idx: idx).first
    end

    def with_orm(orm : User::ORM)
      where orm: orm.to_s
    end

    def in_ascending_id_order
      order_by id: :asc
    end

    def create(idx : Int32)
      insert name: "Interro #{idx}", orm: "interro", idx: idx
    end

    def set_name(user : User, name : String)
      where(id: user.id).update(name: name).first
    end

    def delete(user : User)
      where(id: user.id).delete
    end
  end

  def simple_insert(idx : Int32)
    UserQuery.new.create idx
  end

  def simple_select(idx : Int32)
    UserQuery.new
      .with_orm(:interro)
      .in_ascending_id_order
      .map(&.name)
  end

  def simple_update(idx : Int32)
    u = UserQuery.new.with_orm(:interro).find_by_idx!(idx)
    UserQuery.new.set_name u, "Interro #{idx}"
  end

  def simple_delete(idx : Int32)
    u = UserQuery.new.with_orm(:interro).find_by_idx!(idx)
    UserQuery.new.delete u
  end
end
