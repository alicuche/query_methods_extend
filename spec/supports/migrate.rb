require "query_methods_extend"
require "query_methods_extend/basic"
require "query_methods_extend/association"
require "query_methods_extend/like"
require "query_methods_extend/operators"
require "query_methods_extend/or"
require "query_methods_extend/union"
require 'models/book.rb'
require 'models/category.rb'
require 'models/store.rb'

def run_migrate
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: ':memory:'
  )

  ActiveRecord::Schema.define do
    create_table :books do |t|
      t.string :name
      t.integer :price
      t.references :category

      t.timestamps
    end

    create_table :categories do |t|
      t.string :name
      t.references :store

      t.timestamps
    end

    create_table :stores do |t|
      t.string :address

      t.timestamps
    end
  end
end