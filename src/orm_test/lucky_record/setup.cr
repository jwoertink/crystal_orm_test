module OrmTestLuckyRecord
  extend self

  LuckyRecord::Repo.configure do
    settings.url = "postgres://#{DATABASE[:user]}@#{DATABASE[:host]}/#{DATABASE[:name]}"
  end

  class User < LuckyRecord::Model
    table :users do
      column name : String
    end
  end

  class UserMutation < User::BaseForm 
    fillable name
  end

  # INSERT INTO users(name) VALUES(whatever)
  def simple_insert
    u = UserMutation.new
    u.name.value = "LuckyRecordGuy #{rand(10_000)}"
    u.save!
  end
end
