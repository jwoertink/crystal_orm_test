module OrmTestLuckyRecord
  extend self

  LuckyRecord::Repo.configure do
    settings.url = "postgres://#{DATABASE[:user]}@#{DATABASE[:host]}/#{DATABASE[:name]}"
  end

  class User < LuckyRecord::Model
    table :users do
      column name : String
      column orm : String
      column idx : Int32
    end
  end

  class UserMutation < User::BaseForm 
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
  def simple_select
    User::BaseQuery.new.orm("lucky_record").id.asc_order.map(&.name)
  end
end
