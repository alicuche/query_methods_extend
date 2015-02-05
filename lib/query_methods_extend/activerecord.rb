module ActiveRecord
  module QueryMethods
    include QueryMethodsExtend::Association

    def method_missing(method_name, *args, &block)
      if respond_to? method_name
        super
      else
        check_association_exist(method_name) || super
      end
    end
  end
end