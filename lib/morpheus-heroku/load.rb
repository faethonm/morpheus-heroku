module MorpheusHeroku
  module Load
    extend self

    def run
      ensure_db_environment! if Rails.env.development?
      drop_database!
      create_database!
      load_database!
    end

    private

    def ensure_db_environment!
      Helper.bash_run(command: "bundle exec rake db:environment:set RAILS_ENV=development")
    end

    def drop_database!
      Helper.logger("Rake::Task['db:drop']")
      Rake::Task["db:drop"].invoke
    end

    def create_database!
      Helper.logger("Rake::Task['db:create']")
      Rake::Task["db:create"].invoke
    end

    def load_database!
      Helper.bash_run(command: "pg_restore -O -n public -d #{MorpheusHeroku.configuration.database_name} #{MorpheusHeroku.configuration.backup_location}")
    end
  end
end
