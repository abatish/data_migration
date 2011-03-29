namespace :db do
  namespace :data do
    desc 'Migrate the database through scripts in db/data/migrate. Target specific version with VERSION=x. Turn off output with VERBOSE=false. You can specify a path to load with db:data:migrate[<path-here>]'
    task :migrate, :path, :args do |path, args|
      Rake::Task[:environment].invoke
      ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
      ActiveRecord::Migrator.migrate( (args[:path] || 'db/data'), ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
    end
  end
end