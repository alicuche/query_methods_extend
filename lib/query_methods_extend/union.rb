module QueryMethodsExtend
  module Union extend ActiveSupport::Concern
    included do
      scope :union, ->(query){
        query_self = self.all.to_sql
        self.unscoped.from("(#{query_self} UNION #{query.to_sql}) AS #{self.table_name}")
      }
    end
  end
end