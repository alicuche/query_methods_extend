# QueryMethodsExtend

Extend query activerecord in rails 4
https://rubygems.org/gems/query_methods_extend

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'query_methods_extend'
```

And model file:
```ruby
include QueryMethodsExtend
```

## Usage

The structure book models:
```ruby
class Store < ActiveRecord::Base
  include QueryMethodsExtend
  has_many :categories
end
// Store(id: integer, address: string)

class Category < ActiveRecord::Base
  include QueryMethodsExtend
  belongs_to :store
  has_many :books
end
// Category(id: integer, name: string, store_id: integer)

class Book < ActiveRecord::Base
  include QueryMethodsExtend
  belongs_to :category
end
// Book(id: integer, name: string, price: integer, category_id: integer)
```

## Has_many with collection
Before with asscociation **:has_many**, take **all categories in the stores** in Vietnam, we can write:
```ruby
Category.where(store_id: Store.where(address: 'Vietnam'))
```
And now we can write in collection:
```ruby
Store.where(address: 'Vietnam').categories

***
SELECT "categories".* FROM "categories"
  WHERE (categories.store_id IN (
    SELECT "stores"."id" FROM "stores"  WHERE "stores"."address" = 'Vietnam'
  )
)
```

And take **all books in the stores** in Vietnam (without use **:through**):
```ruby
Store.where(address: 'Vietnam').categories.books

***
SELECT "books".* FROM "books"
  WHERE (books.category_id IN (
    SELECT "categories"."id" FROM "categories"
      WHERE (categories.store_id IN (
        SELECT "stores"."id" FROM "stores"  WHERE "stores"."address" = 'Vietnam'
      )
    )
  )
)
```

## Union query
```ruby
query_one = Book.where(price: 10).select(:name, :price)
query_two = Book.where(created_at: DateTime.now).select(:name, :price)
query_one.union(query_two)

***
SELECT "books".* FROM (
  SELECT "books"."name", "books"."price" FROM "books"
    WHERE "books"."created_at" = '2015-01-22 15:28:17.524026'
  UNION SELECT "books"."name", "books"."price" FROM "books"
    WHERE "books"."price" = 10
) AS books
```

```ruby
query = Book.where(price: 10)
Book.where(created_at: DateTime.now).union(query).where(name: 'Happy')

***
SELECT "books".* FROM (
  SELECT "books".* FROM "books"
    WHERE "books"."created_at" = '2015-01-22 15:57:14.143253'
  UNION SELECT "books".* FROM "books"
    WHERE "books"."price" = 10
) AS books
WHERE "books"."name" = 'Happy'
```

```ruby
query_one = Book.where(price: 10)
query_two = Book.where(price: 15)
Book.where(created_at: DateTime.now).union(query_one).union(query_two)

***
SELECT "books".* FROM (
  SELECT "books".* FROM (
    SELECT "books".* FROM "books"
      WHERE "books"."created_at" = '2015-01-22 16:00:10.364535'
    UNION SELECT "books".* FROM "books"
      WHERE "books"."price" = 10
  ) AS books
  UNION SELECT "books".* FROM "books"
    WHERE "books"."price" = 15
) AS books
```

## Or query
```ruby
Book.where(price: 10, name: 'Rails').or.where(price: 15, name: 'Happy')

***
SELECT "books".* FROM "books"
  WHERE (("books"."price" = 10 AND "books"."name" = 'Rails')
    OR ("books"."price" = 15 AND "books"."name" = 'Happy'))
```

```ruby
Book.where(price: 10, name: 'Rails').or(price: 15, name: 'Happy')

***
SELECT "books".* FROM "books"
  WHERE "books"."price" = 10
    AND "books"."name" = 'Rails'
    AND ("books"."price" = 15 OR "books"."name" = 'Happy')
```

```ruby
Book.where(price: 10, name: 'Rails').or.where(price: 15, name: 'Ruby').or(price: 15, id: 1..5)

***
SELECT "books".* FROM "books"
  WHERE (("books"."price" = 10 AND "books"."name" = 'Rails')
    OR ("books"."price" = 15 AND "books"."name" = 'Ruby'))
    AND ("books"."price" = 15 OR "books"."id" BETWEEN 1 AND 5)
```

## Like query
```ruby
Book.like(name: 'ruby', price: '$')
***
SELECT "books".* FROM "books"  WHERE (books.name LIKE '%ruby%' AND books.price LIKE '%$%')

Book.l_like(name: 'ruby')
***
SELECT "books".* FROM "books"  WHERE (books.name LIKE '%ruby')

Book.r_like(name: 'ruby')
***
SELECT "books".* FROM "books"  WHERE (books.name LIKE 'ruby%')

Book.regex_like(name: '%ruby%')
***
SELECT "books".* FROM "books"  WHERE (books.name LIKE '%ruby%')
```

## Operators query
```ruby
Book.lt(price: 5, id: 10)
***
SELECT "books".* FROM "books"  WHERE (books.price < 5 AND books.id < 10)

Book.lteq(price: 5)
***
SELECT "books".* FROM "books"  WHERE (books.price <= 5)

Book.gt(price: 5)
***
SELECT "books".* FROM "books"  WHERE (books.price > 5)

Book.gteq(price: 5)
***
SELECT "books".* FROM "books"  WHERE (books.price >= 5)
```



## Contributing

1. Fork it ( https://github.com/alicuche/query_methods_extend/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
