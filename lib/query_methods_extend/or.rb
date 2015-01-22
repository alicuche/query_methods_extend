module QueryMethodsExtend
  module ExtendMethods
    @is_query_or = false

    def set_is_query_or value
      @is_query_or = value if self.where_values.size > 0
      self
    end

    def where!(opts, *rest)
      if Hash === opts
        opts = sanitize_forbidden_attributes(opts)
        references!(ActiveRecord::PredicateBuilder.references(opts))
      end

      if @is_query_or
        set_is_query_or false
        self.where_values = ["(#{build_string_where(self.where_values)}) OR (#{build_string_where(build_where(opts, rest))})"]
      else
        self.where_values += build_where(opts, rest)
      end
      self
    end

    def build_string_where where_data
      where_data.map{ |data| data.class == String ? data : data.to_sql }.join(' AND ')
    end

  end

  module OrQuery extend ActiveSupport::Concern
    included do
      scope :or, ->(agrs = nil){
        if agrs
          if agrs.class == Hash
            act = self.unscoped.where(agrs).where_values.map{ |data| data.to_sql }.join(' OR ')
            self.where("(#{act})")
          else
            raise 'Agruments should be a HASH'
          end
        else
          all.extending(ExtendMethods).set_is_query_or(true)
        end
      }
    end
  end
end