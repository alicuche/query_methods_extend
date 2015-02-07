require "query_methods_extend/version"
require "query_methods_extend/railtie"
require "query_methods_extend/association"
require "query_methods_extend/or"
require "query_methods_extend/like"
require "query_methods_extend/operators"
require "query_methods_extend/union"
require "query_methods_extend/activerecord"

module QueryMethodsExtend extend ActiveSupport::Concern
  included do
    include Association
    include OrQuery
    include Like
    include Operators
    include Union
  end
end


