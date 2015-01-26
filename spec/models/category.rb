class Category < ActiveRecord::Base
  include QueryMethodsExtend
  belongs_to :store
  has_many :books
end
