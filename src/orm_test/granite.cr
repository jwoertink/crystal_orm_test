require "pg"
require "granite"
require "granite/adapter/pg"

# HACK: This fixes a conflict between Avram and Grainte
# running at the same time
module JSON::Serializable
  macro included
    def self.adapter
      begin
        @@current_adapter.not_nil!
      rescue NilAssertionError
        Granite::Connections.registered_connections.first?.not_nil![:writer]
      end
    end
  end
end

require "./granite/setup"
