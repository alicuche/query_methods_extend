module ActiveRecord
  module QueryMethods
    include QueryMethodsExtend::Association
    include QueryMethodsExtend::Like
    include QueryMethodsExtend::Operators
    include QueryMethodsExtend::OrQuery
    include QueryMethodsExtend::Union

    def method_missing(method_name, *args, &block)
      check_association_exist(method_name) || super
    end

  end
end