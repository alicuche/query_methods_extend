module QueryMethodsExtend
  module Operators extend ActiveSupport::Concern
    included do
      def self.gt agrs
        @extend_operator_string = '>'
        operator_basic agrs
      end

      def self.gteq agrs
        @extend_operator_string = '>='
        operator_basic agrs
      end

      def self.lt agrs
        @extend_operator_string = '<'
        operator_basic agrs
      end

      def self.lteq agrs
        @extend_operator_string = '<='
        operator_basic agrs
      end

      private
        def self.operator_basic agrs
          if agrs.class == Hash
            items = self
            agrs.each do |agr|
              field, value = agr
              items = items.where("#{self.table_name}.#{field} #{@extend_operator_string} ?", value)
            end
            return items
          else
            raise "Operators '#{@extend_operator_string}' with agruments should be a HASH"
          end
        end

    end
  end
end