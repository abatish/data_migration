namespace :db do
  namespace :data do
    desc 'Migrate the database through scripts in db/data/migrate. Target specific version with VERSION=x. Turn off output with VERBOSE=false. You can specify a path with PATH=x.'
    task :migrate => :environment do
      path = ARGV.grep(/^PATH/).first.split('=').last if ARGV.grep(/^PATH/)
      path ||= 'db/data'

      ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
      ActiveRecord::Migrator.migrate(path, ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
    end    
  end
end