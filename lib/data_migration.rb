module ActiveRecord
  class Migration
    class << self
      def add_data(obj, *args)
        args = args.pop
        method_name = ('find_or_create_by_'+create_method_name(args)).to_sym
        #obj = obj.classify.constantize
        obj.send(method_name, args)
      end

      def remove_data(obj, *args)
        args = args.pop
        method_name = ('find_by_'+create_method_name(args)).to_sym
        #obj = obj.classify.constantize
        result = obj.send(method_name, *args.values)
        result.destroy if result
      end

      private
      def create_method_name(args)
        args.keys.join('_and_')
      end
    end
  end
end