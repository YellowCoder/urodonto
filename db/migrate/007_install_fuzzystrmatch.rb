class InstallFuzzystrmatch < ActiveRecord::Migration[5.2]
  def self.up
    ActiveRecord::Base.connection.execute("CREATE EXTENSION pg_trgm;")
    ActiveRecord::Base.connection.execute("CREATE EXTENSION unaccent;")
  end

  def self.down
    ActiveRecord::Base.connection.execute("DROP EXTENSION pg_trgm;")
    ActiveRecord::Base.connection.execute("DROP EXTENSION unaccent;")
  end
end
