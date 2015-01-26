class Book < ActiveRecord::Base
  include QueryMethodsExtend
  belongs_to :category
end
