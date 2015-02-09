module QueryMethodsExtend
  module Association extend ActiveSupport::Concern
    included do
      @check_association_exist_flag = false

      def self.check_association_exist method_name
        if @check_association_exist_flag
          return false
        end

        @check_association_exist_flag = true

        association = self.try(:reflect_on_association, method_name)
        result = false
        if association && association.try(:macro) == :has_many
          options = association.options

          if options[:through]
            @check_association_exist_flag = false
            return self.all.send(options[:through]).send(method_name)
          end

          query = self.select(association.active_record.primary_key)

          if options[:as] && !association.inverse_of && association.klass
            polymorphic_as = association.klass.reflect_on_association(options[:as])
            if polymorphic_as.polymorphic? && association.active_record
              polymorphic_model = polymorphic_as.active_record
              model = association.active_record
              @check_association_exist_flag = false
              return polymorphic_as.active_record
                .where("#{polymorphic_model.table_name}.#{polymorphic_as.foreign_type}".to_sym => model.name)
                .where("#{polymorphic_model.table_name}.#{polymorphic_as.foreign_key}".to_sym => query)
            end
          end

          model = association.options[:class] || association.inverse_of.active_record
          foreign_key = association.options[:foreign_key] || association.inverse_of.foreign_key

          result = model.where("#{model.table_name}.#{foreign_key.to_s}".to_sym => query)

        end

        @check_association_exist_flag = false
        return result
      end
    end
  end
end