require "query_methods_extend/version"
require "query_methods_extend/or"
require "query_methods_extend/like"
require "query_methods_extend/operators"
require "query_methods_extend/union"

module QueryMethodsExtend extend ActiveSupport::Concern
  included do
    include OrQuery
    include Like
    include Operators
    include Union
  end
end
