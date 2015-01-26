class Store < ActiveRecord::Base
  include QueryMethodsExtend
  has_many :categories
end
