module ActiveRecord
  class Migration
    class << self
      def add_data(obj, *args)
        args = args.pop
        method_name = create_method_name(
          :method => :add_data,
          :force_create => args[:force_create],
          :arguments => args
        )

        args.delete :force_create if args[:force_create]
        obj.send(method_name, args)
      end

      def remove_data(obj, *args)
        args = args.pop
        method_name = create_method_name(
          :method => :remove_data,
          :arguments => args
        )

        result = obj.send(method_name, *args.values)
        result.destroy if result
      end

      private
      def create_method_name(*args)
        args = args.pop
        case args[:method]
          when :add_data
            method_name = args[:force_create] ? 'create' : 'find_or_create_by_'
          when :remove_data
            method_name = 'find_by_'
        end

        unless args[:force_create]
          method_name = (method_name+args[:arguments].keys.join('_and_')).to_sym
        end

        return method_name
      end
    end
  end
end