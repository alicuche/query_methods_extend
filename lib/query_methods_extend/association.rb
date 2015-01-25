module QueryMethodsExtend
  module Association
    @check_association_exist_flag = false

    def method_missing(method_name, *args, &block)
      if respond_to? method_name
        super
      else
        check_association_exist(method_name) || super
      end
    end

    def check_association_exist method_name
      if @check_association_exist_flag
        return false
      end

      @check_association_exist_flag = true

      association = self.try(:reflect_on_association, method_name)
      result = false
      if association && association.macro == :has_many
        model_reflect = association.inverse_of
        model = model_reflect.active_record
        query = self.select(association.primary_key_column.name)
        result = model.where("#{model.table_name}.#{model_reflect.foreign_key.to_sym} IN (#{query.to_sql})")
      end

      @check_association_exist_flag = false
      return result
    end
  end
end