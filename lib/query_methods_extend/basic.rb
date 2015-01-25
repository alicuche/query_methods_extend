module QueryMethodsExtend
  module Basic extend ActiveSupport::Concern
    included do
      def self.where(opts, *rest)
        super(opts, *rest).all.extending(Association, OrExtend)
      end
    end
  end
end