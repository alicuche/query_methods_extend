module QueryMethodsExtend
  module Operators extend ActiveSupport::Concern
    included do
      scope :gt, ->(agrs){
        @extend_operator_string = '>'
        operator_basic agrs
      }

      scope :gteq, ->(agrs){
        @extend_operator_string = '>='
        operator_basic agrs
      }

      scope :lt, ->(agrs){
        @extend_operator_string = '<'
        operator_basic agrs
      }

      scope :lteq, ->(agrs){
        @extend_operator_string = '<='
        operator_basic agrs
      }

      scope :operator_basic, ->(agrs){
        if agrs.class == Hash
          items = self
          agrs.each do |agr|
            field, value = agr
            items = items.where("#{self.table_name}.#{field} #{@extend_operator_string} ?", value)
          end
          return items
        else
          raise 'Agruments should be a HASH'
        end
      }
    end
  end
end