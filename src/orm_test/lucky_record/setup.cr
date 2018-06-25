module OrmTestLuckyRecord
  extend self

  LuckyRecord::Repo.configure do
    #settings.url = "postgres://#{DATABASE[:user]}@#{DATABASE[:host]}/#{DATABASE[:name]}"
    settings.url = "postgres://postgres@localhost/crystal_orm_test"
  end

  class User < LuckyRecord::Model
    table :users do
      column name : String
      column orm : String
      column idx : Int32
    end
  end

  class UserMutation < User::BaseForm
    fillable name
  end

  # INSERT INTO users(name) VALUES(whatever)
  def simple_insert(idx : Int32)
    u = UserMutation.new
    u.name.value = "LuckyRecordGuy #{idx}"
    u.orm.value = "lucky_record"
    u.idx.value = idx
    u.save!
  end
  
  # SELECT * FROM users WHERE orm = 'lucky_record' ORDER BY id ASC
  # Map all of the names in to an array
  def simple_select(idx : Int32)
    User::BaseQuery.new.orm("lucky_record").id.asc_order.map(&.name)
  end
  
  # Find user by orm and idx
  # update name
  # NOTE: This makes 2 SQL calls. Though it's not "optimized", it's more practical for real world
  def simple_update(idx_value : Int32)
    q = User::BaseQuery.new.orm("lucky_record").idx(idx_value).first
    u = UserMutation.new(q)
    u.name.value = "Lucky Guy#{idx_value}"
    u.save!
  end
end
