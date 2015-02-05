module QueryMethodsExtend
  module Like extend ActiveSupport::Concern
    included do
      attr_accessor :extend_like_string

      scope :like, ->(agrs){
        @extend_like_string = '%{?}%'
        like_basic agrs
      }

      scope :l_like, ->(agrs){
        @extend_like_string = '%{?}'
        like_basic agrs
      }

      scope :r_like, ->(agrs){
        @extend_like_string = '{?}%'
        like_basic agrs
      }

      scope :regex_like, ->(agrs){
        @extend_like_string = '{?}'
        like_basic agrs
      }

      scope :like_basic, ->(agrs){
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
      }
    end
  end
end