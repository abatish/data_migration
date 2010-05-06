class DataMigrationGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      path = ARGV.grep(/^PATH/).first.split('=').last if ARGV.grep(/^PATH/)
      path ||= 'db/data'

      m.migration_template 'migration.rb', path, :assigns => get_local_assigns
    end
  end
  
  
  private
  def get_local_assigns
    returning(assigns = {}) do
      if class_name.underscore =~ /^(add|remove)_.*_(?:to|from)_(.*)/
        assigns[:migration_action] = $1
        assigns[:table_name] = $2.pluralize
      else
        assigns[:attributes] = []
      end
    end
  end
end