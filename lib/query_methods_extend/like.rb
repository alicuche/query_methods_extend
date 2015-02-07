module QueryMethodsExtend
  module Like extend ActiveSupport::Concern
    included do
      attr_accessor :extend_like_string

      def self.like agrs
        @extend_like_string = '%{?}%'
        like_basic agrs
      end

      def self.l_like agrs
        @extend_like_string = '%{?}'
        like_basic agrs
      end

      def self.r_like agrs
        @extend_like_string = '{?}%'
        like_basic agrs
      end

      def self.regex_like agrs
        @extend_like_string = '{?}'
        like_basic agrs
      end

      private
        def self.like_basic agrs
          if agrs.class == Hash
            items = self
            agrs.each do |agr|
              field, value = agr
              items = items.where("#{self.table_name}.#{field} LIKE ?", @extend_like_string.gsub('{?}', value.to_s))
            end
            return items
          else
            raise "Like method with agruments should be a HASH"
          end
        end

    end
  end
end