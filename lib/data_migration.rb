module ActiveRecord
  module ConnectionAdapters # :nodoc:
    module SchemaStatements
      def add_data(obj, *args)
        obj = obj.classify.constantize
        obj.find_or_create(args)
      end

      def remove_data(obj, *args)
        obj = obj.classify.constantize
        method_name = 'find_by_'+args.keys.join('_and_')
        result = obj.send(method_name.to_sym, *args.values)
        result.destroy if result
      end
    end
  end
end